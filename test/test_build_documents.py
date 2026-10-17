"""Checks for the build pipeline, without requiring Typst in each unit test."""
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from urllib.parse import unquote
from html.parser import HTMLParser

REPOSITORY = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "build_documents", REPOSITORY / ".github/scripts/build_documents.py")
PIPELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PIPELINE)
HTML_TEMPLATE = (REPOSITORY / PIPELINE.TEMPLATE).read_text(encoding="utf-8")


def fake_compile(source, target, root):
    target.write_bytes(b"%PDF-1.4\n" + source.read_bytes())


class Links(HTMLParser):
    def __init__(self):
        super().__init__()
        self.hrefs = []

    def handle_starttag(self, tag, attrs):
        if tag == "a":
            self.hrefs.extend(value for key, value in attrs if key == "href")


class DocumentationBuildTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="byteclub-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.write(PIPELINE.TEMPLATE, HTML_TEMPLATE)

    def write(self, relative, value):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        if isinstance(value, bytes):
            path.write_bytes(value)
        else:
            path.write_text(value, encoding="utf-8")
        return path

    def run_build(self, **kwargs):
        return PIPELINE.build(self.root, compiler=fake_compile, **kwargs)

    def snapshot(self):
        return {p.relative_to(self.root).as_posix(): p.read_bytes()
                for p in self.root.rglob("*") if p.is_file()}

    def test_empty_sections_have_the_requested_message(self):
        self.assertEqual(self.run_build(), [])
        generated = (self.root / "website/index.generated.html").read_text(encoding="utf-8")
        self.assertEqual(generated.count(PIPELINE.EMPTY), 4)

    def test_recursive_scope_preserves_names_and_is_idempotent(self):
        self.write("docs/1_Diario_di_bordo/rtb/DDB 2026-10-17 v0.1.0.typ", "Diario")
        self.write("docs/2_Candidatura/verbali/interni/VI_2026-10-13.typ", "Verbale")
        self.write("docs/2_Candidatura/Lettera.TYP", "Lettera")
        self.write("docs/5_Templates/base.typ", "Non compilare")
        self.write("docs/3_RTB/Analisi.typ", "Non compilare")
        outputs = self.run_build()
        self.assertEqual(len(outputs), 3)
        for name in outputs:
            self.assertTrue((self.root / "docs/6_Output" / name).is_file())
        before = self.snapshot()
        self.run_build()
        self.assertEqual(self.snapshot(), before)
        self.assertEqual((self.root / PIPELINE.TEMPLATE).read_text(encoding="utf-8"),
                         HTML_TEMPLATE)

    def test_compilation_failure_keeps_previous_pdf_catalog_and_manifest(self):
        self.write("docs/2_Candidatura/Documento.typ", "Versione precedente")
        self.run_build()
        self.write("docs/2_Candidatura/Documento.typ", "Versione nuova")
        self.write("docs/2_Candidatura/Z_non_valido.typ", "Errore")
        before = self.snapshot()

        def fail_second(source, target, root):
            if source.stem == "Z_non_valido":
                raise subprocess.CalledProcessError(1, ["typst"])
            fake_compile(source, target, root)

        with self.assertRaises(subprocess.CalledProcessError):
            PIPELINE.build(self.root, compiler=fail_second)
        self.assertEqual(self.snapshot(), before)

    def test_rename_removes_only_owned_outputs_and_keeps_signed_pdf(self):
        source = self.write("docs/2_Candidatura/Vecchio.typ", "Versione")
        signed = self.write("docs/6_Output/2_Candidatura/verbali/esterni/Firmato.pdf",
                            b"%PDF-manuale")
        self.run_build()
        source.unlink()
        self.write("docs/2_Candidatura/Nuovo.typ", "Versione aggiornata")
        self.run_build()
        self.assertFalse((self.root / "docs/6_Output/2_Candidatura/Vecchio.pdf").exists())
        self.assertEqual(signed.read_bytes(), b"%PDF-manuale")
        page = (self.root / "website/index.generated.html").read_text(encoding="utf-8")
        self.assertNotIn("Vecchio.pdf", page)
        self.assertIn("Nuovo.pdf", page)
        self.assertIn("Firmato.pdf", page)

    def test_unicode_spaces_html_characters_and_keyword_like_names(self):
        self.write("docs/2_Candidatura/Verbale è & [VERBALI_INTERNI] v0.1.0.typ", "Test")
        self.run_build()
        page = (self.root / "website/index.generated.html").read_text(encoding="utf-8")
        self.assertIn("&amp;", page)
        self.assertIn("%20", page)
        self.assertIn("%26", page)
        self.assertIn("%C3%A8", page)
        self.assertIn("[VERBALI_INTERNI]", page)

    def test_links_resolve_in_both_repository_and_pages_artifact(self):
        self.write("docs/2_Candidatura/verbali/interni/VI 2026-10-13.typ", "Test")
        self.run_build(site=True)
        for page in [self.root / "website/index.generated.html", self.root / ".site-build/index.html"]:
            parser = Links()
            parser.feed(page.read_text(encoding="utf-8"))
            self.assertTrue(parser.hrefs)
            for href in parser.hrefs:
                self.assertTrue((page.parent / unquote(href)).resolve().is_file(), href)

    def test_catalog_lists_only_current_sections_and_preserves_other_outputs(self):
        documents = [
            "1_Diario_di_bordo/rtb/DDB.pdf",
            "2_Candidatura/Lettera.pdf",
            "2_Candidatura/verbali/interni/VI.pdf",
            "2_Candidatura/verbali/esterni/VE.pdf",
            "2_Candidatura/verbali/Altro.pdf",
            "2_Candidatura/verbali/archivio/Storico.pdf",
            "3_RTB/Analisi.pdf",
            "3_RTB/verbali/interni/VI_RTB.pdf",
            "4_PB/sottocartella/Manuale.pdf",
            "0_Verbale/Verbale.pdf",
            "5_Templates/Esempio.pdf",
            "7_Futura/Nuovo.pdf",
            "Documento_radice.pdf",
        ]
        for name in documents:
            self.write("docs/6_Output/" + name, b"%PDF-manuale")
        self.assertEqual(self.run_build(site=True), [])
        for page in [self.root / "website/index.generated.html", self.root / ".site-build/index.html"]:
            parser = Links()
            parser.feed(page.read_text(encoding="utf-8"))
            self.assertEqual(len(parser.hrefs), 6)
            self.assertEqual(len(set(parser.hrefs)), 6)
            content = page.read_text(encoding="utf-8")
            for heading in ("3_RTB", "4_PB", "Altri documenti"):
                self.assertNotIn(heading, content)
            for href in parser.hrefs:
                self.assertEqual((page.parent / unquote(href)).resolve().read_bytes(),
                                 b"%PDF-manuale")
        for name in documents:
            for base in (self.root, self.root / ".site-build"):
                self.assertEqual((base / "docs/6_Output" / name).read_bytes(), b"%PDF-manuale")
        manifest = json.loads((self.root / PIPELINE.MANIFEST).read_text(encoding="utf-8"))
        self.assertEqual(manifest["outputs"], [])

    def test_bad_keyword_does_not_replace_existing_outputs(self):
        self.write("docs/2_Candidatura/Documento.typ", "Prima")
        self.run_build()
        self.write(PIPELINE.TEMPLATE, HTML_TEMPLATE + "[KEYWORD_SBAGLIATA]")
        self.write("docs/2_Candidatura/Documento.typ", "Dopo")
        before = self.snapshot()
        with self.assertRaisesRegex(ValueError, "Keyword sconosciute"):
            self.run_build()
        self.assertEqual(self.snapshot(), before)

    def test_manifest_cannot_delete_a_path_outside_managed_directories(self):
        protected = self.write("docs/6_Output/3_RTB/Protetto.pdf", b"%PDF-protetto")
        self.write(PIPELINE.MANIFEST, json.dumps({
            "schema": 1, "outputs": ["3_RTB/Protetto.pdf"]}))
        before = self.snapshot()
        with self.assertRaises(ValueError):
            self.run_build()
        self.assertEqual(self.snapshot(), before)
        self.assertEqual(protected.read_bytes(), b"%PDF-protetto")


if __name__ == "__main__":
    unittest.main()
