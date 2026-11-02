#!/usr/bin/env python3
"""Update the formula from a published CLI version or a local macOS ARM64 ZIP."""

import argparse
import hashlib
import re
import shutil
import tempfile
import urllib.error
import urllib.request
import zipfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
FORMULA = ROOT / "Formula" / "foundrylocal.rb"
VERSION = r"[0-9]+\.[0-9]+\.[0-9]+"
ARCHIVE_NAME = re.compile(rf"foundry-({VERSION})-osx-arm64\.zip")


def update_formula(formula, archive, version, url):
    with zipfile.ZipFile(archive) as package:
        bad_file = package.testzip()
        if bad_file:
            raise ValueError(f"ZIP integrity check failed: {bad_file}")
        files = {entry.filename for entry in package.infolist() if not entry.is_dir()}
        roots = {name.split("/")[0] for name in files}
        if len(roots) != 1:
            raise ValueError("Expected a single top-level directory in the archive")
        prefix = roots.pop() + "/bin/"
        required = (
            "foundry", "foundrylocald", "libonnxruntime-genai.dylib",
            "libonnxruntime.dylib", "libfoundry_local.dylib",
        )
        if any(prefix + name not in files for name in required):
            raise ValueError("Archive is missing a required CLI executable or library")
        if not any(name.startswith(prefix + "notices/") for name in files):
            raise ValueError("Archive is missing bundled notices")

    digest = hashlib.sha256()
    with archive.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    with formula.open(encoding="utf-8", newline="") as source:
        text = source.read()
    for field, value in (("url", url), ("version", version), ("sha256", digest.hexdigest())):
        text, count = re.subn(
            rf'^  {field} "[^"\r\n]*"', lambda _: f'  {field} "{value}"', text,
            flags=re.MULTILINE,
        )
        if count != 1:
            raise ValueError(f"Expected exactly one top-level {field} in {formula}")
    with formula.open("w", encoding="utf-8", newline="") as destination:
        destination.write(text)
    print(f"Updated {formula}: {version} (sha256: {digest.hexdigest()})")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--version", help="Published CLI version, e.g. 0.13.0")
    parser.add_argument("--archive", type=Path, help="Local foundry-VERSION-osx-arm64.zip")
    args = parser.parse_args(argv)
    if not args.version and not args.archive:
        parser.error("provide --version, --archive, or both")
    version = args.version
    archive = args.archive.expanduser() if args.archive else None
    if archive:
        match = ARCHIVE_NAME.fullmatch(archive.name)
        if not match:
            parser.error("--archive must be named foundry-VERSION-osx-arm64.zip")
        if version and version != match[1]:
            parser.error("--version does not match the archive filename")
        version = match[1]
    if not re.fullmatch(VERSION, version):
        parser.error("--version must have the form MAJOR.MINOR.PATCH")
    url = (
        "https://github.com/microsoft/Foundry-Local/releases/download/"
        f"cli-preview-{version}/foundry-{version}-osx-arm64.zip"
    )
    try:
        if archive:
            update_formula(FORMULA, archive, version, url)
        else:
            build = ROOT / "build"
            build.mkdir(exist_ok=True)
            with tempfile.TemporaryDirectory(dir=build) as temporary:
                archive = Path(temporary) / f"foundry-{version}-osx-arm64.zip"
                with urllib.request.urlopen(url, timeout=120) as response, archive.open("wb") as target:
                    shutil.copyfileobj(response, target)
                update_formula(FORMULA, archive, version, url)
    except (OSError, ValueError, zipfile.BadZipFile, urllib.error.URLError) as error:
        parser.exit(1, f"error: {error}\n")


if __name__ == "__main__":
    main()
