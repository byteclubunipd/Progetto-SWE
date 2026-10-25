"""Checks for the build pipeline, without requiring Typst in each unit test."""
import importlib.util
import json
from pathlib import Path
import subprocess
import shutil
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


def fakeCompile(source, target, root):
    target.write_bytes(b"%PDF-1.4\n" + source.read_bytes())


class Links(HTMLParser):
    def __init__(self):
        super().__init__()
        self.references = []

    # Nome richiesto dal protocollo HTMLParser.
    def handle_starttag(self, tag, attrs):
        attributes = dict(attrs)
        if (tag == "a" and "href" in attributes
                and not attributes["href"].startswith(("#", "mailto:", "http:"))):
            self.references.append(attributes["href"])
        if (tag == "link" and "href" in attributes
                and not attributes["href"].startswith(("http:", "https:"))):
            self.references.append(attributes["href"])
        if tag == "script" and "src" in attributes:
            self.references.append(attributes["src"])


class DocumentationBuildTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="byteclub-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.write(PIPELINE.TEMPLATE, HTML_TEMPLATE)
        self.write("website/assets/favicon.svg", "<svg></svg>")
        self.write("website/css/style.css", "body {}")
        self.write("website/css/desktop.css", "main {}")
        self.write("website/js/script.js", "/* test */")

    def write(self, relative, value):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        if isinstance(value, bytes):
            path.write_bytes(value)
        else:
            path.write_text(value, encoding="utf-8")
        return path

    def runBuild(self):
        return PIPELINE.build(self.root, compiler=fakeCompile)

    def snapshot(self):
        return {p.relative_to(self.root).as_posix(): p.read_bytes()
                for p in self.root.rglob("*") if p.is_file()}

    def testEmptySectionsHaveTheRequestedMessage(self):
        self.assertEqual(self.runBuild(), [])
        generated = (self.root / "website/build/index.html").read_text(encoding="utf-8")
        self.assertEqual(generated.count(PIPELINE.EMPTY), 4)
        self.assertNotIn("[DATA_AGGIORNAMENTO]", generated)
        self.assertRegex(
            generated,
            r"Ultimo aggiornamento: \d{4}-\d{2}-\d{2}",
        )

    def testRecursiveScopePreservesNamesAndIsIdempotent(self):
        self.write("docs/1_Diario_di_bordo/rtb/DDB_2026-10-17.typ", "Diario")
        self.write("docs/2_Candidatura/verbali/interni/VI_2026-10-13.typ", "Verbale")
        self.write("docs/2_Candidatura/Lettera v0.1.0.TYP", "Lettera")
        self.write("docs/5_Templates/base.typ", "Non compilare")
        self.write("docs/3_RTB/Analisi v0.1.0.typ", "Non compilare")
        outputs = self.runBuild()
        self.assertEqual(len(outputs), 3)
        for name in outputs:
            self.assertTrue((self.root / "docs/6_Output" / name).is_file())
        before = self.snapshot()
        self.runBuild()
        self.assertEqual(self.snapshot(), before)
        self.assertEqual((self.root / PIPELINE.TEMPLATE).read_text(encoding="utf-8"),
                         HTML_TEMPLATE)

    def testCompilationFailureKeepsPreviousPdfCatalogAndManifest(self):
        self.write("docs/2_Candidatura/Documento v0.1.0.typ", "Versione precedente")
        self.runBuild()
        self.write("docs/2_Candidatura/Documento v0.1.0.typ", "Versione nuova")
        self.write("docs/2_Candidatura/Z_non_valido v0.1.0.typ", "Errore")
        before = self.snapshot()

        def failSecond(source, target, root):
            if source.stem == "Z_non_valido v0.1.0":
                raise subprocess.CalledProcessError(1, ["typst"])
            fakeCompile(source, target, root)

        with self.assertRaises(subprocess.CalledProcessError):
            PIPELINE.build(self.root, compiler=failSecond)
        self.assertEqual(self.snapshot(), before)

    def testRenameRemovesOnlyOwnedOutputsAndKeepsSignedPdf(self):
        source = self.write("docs/2_Candidatura/Vecchio v0.1.0.typ", "Versione")
        signed = self.write("docs/6_Output/2_Candidatura/verbali/esterni/Firmato.pdf",
                            b"%PDF-manuale")
        self.runBuild()
        source.unlink()
        self.write("docs/2_Candidatura/Nuovo v0.1.0.typ", "Versione aggiornata")
        self.runBuild()
        self.assertFalse((self.root / "docs/6_Output/2_Candidatura/Vecchio v0.1.0.pdf").exists())
        self.assertEqual(signed.read_bytes(), b"%PDF-manuale")
        page = (self.root / "website/build/index.html").read_text(encoding="utf-8")
        self.assertNotIn("Vecchio%20v0.1.0.pdf", page)
        self.assertIn("Nuovo%20v0.1.0.pdf", page)
        self.assertIn("Firmato.pdf", page)

    def testUnicodeSpacesHtmlCharactersAndKeywordLikeNames(self):
        self.write("docs/2_Candidatura/Verbale è & [VERBALI_INTERNI] v0.1.0.typ", "Test")
        self.runBuild()
        page = (self.root / "website/build/index.html").read_text(encoding="utf-8")
        self.assertIn("&amp;", page)
        self.assertIn("%20", page)
        self.assertIn("%26", page)
        self.assertIn("%C3%A8", page)
        self.assertIn("[VERBALI_INTERNI]", page)

    def testLinksResolveInLocalBuildAndPublishedSite(self):
        self.write("docs/2_Candidatura/verbali/interni/VI_2026-10-13.typ", "Test")
        self.write("website/assets/logo.png", b"immagine di prova")
        self.runBuild()
        buildRoot = self.root / PIPELINE.SITE_BUILD
        publishedRoot = self.root / "published/Progetto-SWE"
        shutil.copytree(buildRoot, publishedRoot)
        for siteRoot in (buildRoot, publishedRoot):
            page = siteRoot / "index.html"
            parser = Links()
            parser.feed(page.read_text(encoding="utf-8"))
            self.assertTrue(parser.references)
            for href in parser.references:
                self.assertTrue((siteRoot / unquote(href)).resolve().is_file(), href)
            self.assertEqual((siteRoot / "assets/logo.png").read_bytes(), b"immagine di prova")
            self.assertEqual((siteRoot / "assets/favicon.svg").read_text(), "<svg></svg>")
            self.assertEqual((siteRoot / "css/style.css").read_text(), "body {}")
            self.assertEqual((siteRoot / "css/desktop.css").read_text(), "main {}")
            self.assertEqual((siteRoot / "js/script.js").read_text(), "/* test */")

    def testCatalogListsOnlyCurrentSectionsAndPreservesOtherOutputs(self):
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
            "7_Futura/Nuovo v0.1.0.pdf",
            "Documento_radice.pdf",
        ]
        for name in documents:
            self.write("docs/6_Output/" + name, b"%PDF-manuale")
        self.assertEqual(self.runBuild(), [])
        page = self.root / "website/build/index.html"
        parser = Links()
        parser.feed(page.read_text(encoding="utf-8"))
        pdfReferences = [href for href in parser.references if href.endswith(".pdf")]
        self.assertEqual(len(pdfReferences), 6)
        self.assertEqual(len(set(pdfReferences)), 6)
        content = page.read_text(encoding="utf-8")
        for heading in ("3_RTB", "4_PB", "Altri documenti"):
            self.assertNotIn(heading, content)
        for href in pdfReferences:
            self.assertEqual((page.parent / unquote(href)).resolve().read_bytes(),
                             b"%PDF-manuale")
        for name in documents:
            for base in (self.root, self.root / "website/build"):
                self.assertEqual((base / "docs/6_Output" / name).read_bytes(), b"%PDF-manuale")
        manifest = json.loads((self.root / PIPELINE.MANIFEST).read_text(encoding="utf-8"))
        self.assertEqual(manifest["outputs"], [])

    def testBadKeywordDoesNotReplaceExistingOutputs(self):
        self.write("docs/2_Candidatura/Documento v0.1.0.typ", "Prima")
        self.runBuild()
        self.write(PIPELINE.TEMPLATE, HTML_TEMPLATE + "[KEYWORD_SBAGLIATA]")
        self.write("docs/2_Candidatura/Documento v0.1.0.typ", "Dopo")
        before = self.snapshot()
        with self.assertRaisesRegex(ValueError, "Keyword sconosciute"):
            self.runBuild()
        self.assertEqual(self.snapshot(), before)

    def testManifestCannotDeleteAPathOutsideManagedDirectories(self):
        protected = self.write("docs/6_Output/3_RTB/Protetto.pdf", b"%PDF-protetto")
        self.write(PIPELINE.MANIFEST, json.dumps({
            "schema": 1, "outputs": ["3_RTB/Protetto.pdf"]}))
        before = self.snapshot()
        with self.assertRaises(ValueError):
            self.runBuild()
        self.assertEqual(self.snapshot(), before)
        self.assertEqual(protected.read_bytes(), b"%PDF-protetto")


if __name__ == "__main__":
    unittest.main()
