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
SITE_BUILD = Path("website/build")
EMPTY = "<p>Non ci sono documenti disponibili al momento</p>"


def managedRelative(value: str) -> Path:
    if not isinstance(value, str):
        raise ValueError("Ogni voce del manifest deve essere un percorso")
    path = PurePosixPath(value)
    if (not path.parts or path.is_absolute() or "\\" in value
            or ".." in path.parts or path.parts[0] not in SOURCE_DIRS
            or path.suffix.lower() != ".pdf"):
        raise ValueError(f"Percorso PDF non valido nel manifest: {value}")
    return Path(*path.parts)


def readManifest(root: Path) -> set[str]:
    path = root / MANIFEST
    if not path.exists():
        return set()
    ensureInside(root, path)
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError("Manifest Typst non valido")
    if data.get("schema") != 1 or not isinstance(data.get("outputs"), list):
        raise ValueError("Manifest Typst non valido")
    for name in data["outputs"]:
        managedRelative(name)
    return set(data["outputs"])


def naturalKey(value: str) -> tuple:
    return tuple(int(part) if part.isdigit() else part.casefold()
                 for part in re.split(r"(\d+)", value))


def catalog(directory: Path, outputRoot: Path, prefix: str,
            excluded: tuple[Path, ...] = ()) -> str:
    """Render the directory tree; retain full filenames and URL-encode every path."""
    if not directory.exists():
        return EMPTY
    entries = [entry for entry in directory.iterdir()
               if entry not in excluded and not entry.is_symlink()]
    files = sorted((p for p in entries if p.is_file() and p.suffix.lower() == ".pdf"),
                   key=lambda p: naturalKey(p.name), reverse=True)
    folders = sorted((p for p in entries if p.is_dir()),
                     key=lambda p: naturalKey(p.name))
    items = []
    for file in files:
        url = prefix + quote(file.relative_to(outputRoot).as_posix(), safe="/")
        items.append(f'<li><a href="{html.escape(url, quote=True)}">'
                     f'{html.escape(file.stem)}</a></li>')
    for folder in folders:
        nested = catalog(folder, outputRoot, prefix, excluded)
        if nested != EMPTY:
            items.append(f"<li><strong>{html.escape(folder.name.replace('_', ' '))}"
                         f"</strong>\n{nested}</li>")
    return "<ul>\n" + "\n".join(items) + "\n</ul>" if items else EMPTY


def render(template: str, outputRoot: Path, prefix: str) -> str:
    candidature = outputRoot / "2_Candidatura"
    replacements = {
        "[DIARI_DI_BORDO]": catalog(outputRoot / "1_Diario_di_bordo", outputRoot, prefix),
        "[CANDIDATURA_DOCUMENTI]": catalog(candidature, outputRoot, prefix,
                                          (candidature / "verbali/interni",
                                           candidature / "verbali/esterni")),
        "[VERBALI_INTERNI]": catalog(candidature / "verbali/interni", outputRoot, prefix),
        "[VERBALI_ESTERNI]": catalog(candidature / "verbali/esterni", outputRoot, prefix),
    }
    for keyword in replacements:
        if template.count(keyword) != 1:
            raise ValueError(f"Il template deve contenere una sola occorrenza di {keyword}")
    pattern = r"\[[A-Z][A-Z0-9_]*\]"
    remaining = set(re.findall(pattern, template)) - replacements.keys()
    if remaining:
        raise ValueError(f"Keyword sconosciute: {sorted(remaining)}")
    return re.sub(pattern, lambda match: replacements[match.group()], template)


def ensureInside(root: Path, path: Path) -> None:
    if path.is_symlink() or not path.resolve().is_relative_to(root.resolve()):
        raise ValueError(f"Percorso esterno al progetto o collegamento: {path}")


def atomicWrite(root: Path, path: Path, content: bytes) -> None:
    ensureInside(root, path)
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


def compileTypst(source: Path, target: Path, root: Path) -> None:
    subprocess.run(
        ["typst", "compile", "--root", str(root), "--creation-timestamp", "0",
         str(source), str(target)],
        check=True,
    )


def build(root: Path, *, compiler=compileTypst) -> list[str]:
    root = root.resolve()
    output = root / "docs/6_Output"
    siteTarget = root / SITE_BUILD
    ensureInside(root, siteTarget)
    previous = readManifest(root)
    template = (root / TEMPLATE).read_text(encoding="utf-8")
    sources = []
    for name in SOURCE_DIRS:
        sourceRoot = root / "docs" / name
        ensureInside(root, sourceRoot)
        if sourceRoot.exists():
            for source in sourceRoot.rglob("*"):
                ensureInside(root, source)
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
        ensureInside(root, output)
        if output.exists():
            for file in output.rglob("*"):
                ensureInside(root, file)
                if file.is_file() and file.suffix.lower() == ".pdf":
                    target = candidate / file.relative_to(output)
                    target.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copyfile(file, target)
        for obsolete in previous - set(outputs):
            (candidate / managedRelative(obsolete)).unlink(missing_ok=True)
        for source, name in zip(sources, outputs):
            target = candidate / managedRelative(name)
            target.parent.mkdir(parents=True, exist_ok=True)
            compiler(source, target, root)
            if not target.is_file() or not target.read_bytes().startswith(b"%PDF-"):
                raise ValueError(f"La compilazione non ha prodotto un PDF valido: {source}")
            print(f"Compilato: {source.relative_to(root).as_posix()}")

        # One self-contained site works both locally and on GitHub Pages.
        publishedHtml = render(template, candidate, "docs/6_Output/")
        manifest = json.dumps({"schema": 1, "outputs": outputs},
                              ensure_ascii=False, indent=2) + "\n"
        stagedSite = Path(temporary) / "site"
        stagedSite.mkdir()
        (stagedSite / "index.html").write_text(publishedHtml, encoding="utf-8")
        assets = root / "website/assets"
        if assets.exists():
            ensureInside(root, assets)
            for entry in assets.rglob("*"):
                ensureInside(root, entry)
            shutil.copytree(assets, stagedSite / "assets")
        shutil.copytree(candidate, stagedSite / "docs/6_Output")

        for name in outputs:
            target = output / managedRelative(name)
            atomicWrite(root, target, (candidate / managedRelative(name)).read_bytes())
        for obsolete in previous - set(outputs):
            target = output / managedRelative(obsolete)
            ensureInside(root, target)
            target.unlink(missing_ok=True)
        atomicWrite(root, root / MANIFEST, manifest.encode("utf-8"))

        ensureInside(root, siteTarget)
        # The resolved target is verified above; only website/build is replaced.
        if siteTarget.exists():
            shutil.rmtree(siteTarget)
        shutil.copytree(stagedSite, siteTarget)

    print(f"Build completata: {len(outputs)} documenti.")
    return outputs


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.parse_args()
    try:
        build(Path(__file__).resolve().parents[2])
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print(f"Build interrotta: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
