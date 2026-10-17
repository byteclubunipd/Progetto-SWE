"""Compile the documentation and render its HTML catalog using only the standard library."""
from __future__ import annotations

import argparse
import html
import json
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import sys
import subprocess
import tempfile
from urllib.parse import quote

SOURCE_DIRS = ("1_Diario_di_bordo", "2_Candidatura")
MANIFEST = Path(".github/typst-manifest.json")
TEMPLATE = Path("website/index.html")
GENERATED = Path("website/index.generated.html")
EMPTY = "<p>Non ci sono documenti disponibili al momento</p>"


def managed_relative(value: str) -> Path:
    if not isinstance(value, str):
        raise ValueError("Ogni voce del manifest deve essere un percorso")
    path = PurePosixPath(value)
    if (not path.parts or path.is_absolute() or "\\" in value
            or ".." in path.parts or path.parts[0] not in SOURCE_DIRS
            or path.suffix.lower() != ".pdf"):
        raise ValueError(f"Percorso PDF non valido nel manifest: {value}")
    return Path(*path.parts)


def read_manifest(root: Path) -> set[str]:
    path = root / MANIFEST
    if not path.exists():
        return set()
    ensure_inside(root, path)
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError("Manifest Typst non valido")
    if data.get("schema") != 1 or not isinstance(data.get("outputs"), list):
        raise ValueError("Manifest Typst non valido")
    for name in data["outputs"]:
        managed_relative(name)
    return set(data["outputs"])


def natural_key(value: str) -> tuple:
    return tuple(int(part) if part.isdigit() else part.casefold()
                 for part in re.split(r"(\d+)", value))


def catalog(directory: Path, output_root: Path, prefix: str,
            excluded: tuple[Path, ...] = ()) -> str:
    """Render the directory tree; retain full filenames and URL-encode every path."""
    if not directory.exists():
        return EMPTY
    entries = [entry for entry in directory.iterdir()
               if entry not in excluded and not entry.is_symlink()]
    files = sorted((p for p in entries if p.is_file() and p.suffix.lower() == ".pdf"),
                   key=lambda p: natural_key(p.name), reverse=True)
    folders = sorted((p for p in entries if p.is_dir()),
                     key=lambda p: natural_key(p.name))
    items = []
    for file in files:
        url = prefix + quote(file.relative_to(output_root).as_posix(), safe="/")
        items.append(f'<li><a href="{html.escape(url, quote=True)}">'
                     f'{html.escape(file.stem)}</a></li>')
    for folder in folders:
        nested = catalog(folder, output_root, prefix, excluded)
        if nested != EMPTY:
            items.append(f"<li><strong>{html.escape(folder.name.replace('_', ' '))}"
                         f"</strong>\n{nested}</li>")
    return "<ul>\n" + "\n".join(items) + "\n</ul>" if items else EMPTY


def render(template: str, output_root: Path, prefix: str) -> str:
    candidature = output_root / "2_Candidatura"
    replacements = {
        "[DIARI_DI_BORDO]": catalog(output_root / "1_Diario_di_bordo", output_root, prefix),
        "[CANDIDATURA_DOCUMENTI]": catalog(candidature, output_root, prefix,
                                          (candidature / "verbali/interni",
                                           candidature / "verbali/esterni")),
        "[VERBALI_INTERNI]": catalog(candidature / "verbali/interni", output_root, prefix),
        "[VERBALI_ESTERNI]": catalog(candidature / "verbali/esterni", output_root, prefix),
    }
    for keyword in replacements:
        if template.count(keyword) != 1:
            raise ValueError(f"Il template deve contenere una sola occorrenza di {keyword}")
    pattern = r"\[[A-Z][A-Z0-9_]*\]"
    remaining = set(re.findall(pattern, template)) - replacements.keys()
    if remaining:
        raise ValueError(f"Keyword sconosciute: {sorted(remaining)}")
    return re.sub(pattern, lambda match: replacements[match.group()], template)


def ensure_inside(root: Path, path: Path) -> None:
    if path.is_symlink() or not path.resolve().is_relative_to(root.resolve()):
        raise ValueError(f"Percorso esterno al progetto o collegamento: {path}")


def atomic_write(root: Path, path: Path, content: bytes) -> None:
    ensure_inside(root, path)
    if path.is_file() and path.read_bytes() == content:
        return
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(dir=path.parent, prefix=".typst-", delete=False) as stream:
        temporary = Path(stream.name)
        stream.write(content)
    try:
        os.replace(temporary, path)
    finally:
        temporary.unlink(missing_ok=True)


def compile_typst(source: Path, target: Path, root: Path) -> None:
    subprocess.run(
        ["typst", "compile", "--root", str(root), "--creation-timestamp", "0",
         str(source), str(target)],
        check=True,
    )


def build(root: Path, *, site: bool = False, compiler=compile_typst) -> list[str]:
    root = root.resolve()
    output = root / "docs/6_Output"
    previous = read_manifest(root)
    template = (root / TEMPLATE).read_text(encoding="utf-8")
    sources = []
    for name in SOURCE_DIRS:
        source_root = root / "docs" / name
        ensure_inside(root, source_root)
        if source_root.exists():
            for source in source_root.rglob("*"):
                ensure_inside(root, source)
                if source.is_file() and source.suffix.lower() == ".typ":
                    sources.append(source)
    sources.sort(key=lambda p: p.as_posix().casefold())
    outputs = [p.relative_to(root / "docs").with_suffix(".pdf").as_posix()
               for p in sources]
    if len({name.casefold() for name in outputs}) != len(outputs):
        raise ValueError("Due sorgenti producono lo stesso nome PDF su Windows")

    # Build a complete candidate tree before touching the existing PDF files.
    with tempfile.TemporaryDirectory(prefix="byteclub-docs-") as temporary:
        candidate = Path(temporary) / "output"
        candidate.mkdir()
        ensure_inside(root, output)
        if output.exists():
            for file in output.rglob("*"):
                ensure_inside(root, file)
                if file.is_file() and file.suffix.lower() == ".pdf":
                    target = candidate / file.relative_to(output)
                    target.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copyfile(file, target)
        for obsolete in previous - set(outputs):
            (candidate / managed_relative(obsolete)).unlink(missing_ok=True)
        for source, name in zip(sources, outputs):
            target = candidate / managed_relative(name)
            target.parent.mkdir(parents=True, exist_ok=True)
            compiler(source, target, root)
            if not target.is_file() or not target.read_bytes().startswith(b"%PDF-"):
                raise ValueError(f"La compilazione non ha prodotto un PDF valido: {source}")
            print(f"Compilato: {source.relative_to(root).as_posix()}")

        # Validate both catalog variants before updating the repository.
        repository_html = render(template, candidate, "../docs/6_Output/")
        published_html = render(template, candidate, "docs/6_Output/")
        manifest = json.dumps({"schema": 1, "outputs": outputs},
                              ensure_ascii=False, indent=2) + "\n"
        staged_site = Path(temporary) / "site"
        if site:
            staged_site.mkdir()
            (staged_site / "index.html").write_text(published_html, encoding="utf-8")
            assets = root / "website/assets"
            if assets.exists():
                ensure_inside(root, assets)
                for entry in assets.rglob("*"):
                    ensure_inside(root, entry)
                shutil.copytree(assets, staged_site / "assets")
            shutil.copytree(candidate, staged_site / "docs/6_Output")

        for name in outputs:
            target = output / managed_relative(name)
            atomic_write(root, target, (candidate / managed_relative(name)).read_bytes())
        for obsolete in previous - set(outputs):
            target = output / managed_relative(obsolete)
            ensure_inside(root, target)
            target.unlink(missing_ok=True)
        atomic_write(root, root / GENERATED, repository_html.encode("utf-8"))
        atomic_write(root, root / MANIFEST, manifest.encode("utf-8"))

        if site:
            site_target = root / ".site-build"
            ensure_inside(root, site_target)
            # The resolved target is verified above; only this build directory is replaced.
            if site_target.exists():
                shutil.rmtree(site_target)
            shutil.copytree(staged_site, site_target)

    print(f"Build completata: {len(outputs)} documenti.")
    return outputs


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--site", action="store_true",
                        help="Prepara anche .site-build per GitHub Pages")
    args = parser.parse_args()
    try:
        build(Path(__file__).resolve().parents[2], site=args.site)
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print(f"Build interrotta: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
