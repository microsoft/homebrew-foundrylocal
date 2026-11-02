import contextlib
import hashlib
import io
import re
import tempfile
import unittest
import urllib.error
import zipfile
from pathlib import Path
from unittest.mock import patch

import update_formula


class UpdateFormulaTests(unittest.TestCase):
    def setUp(self):
        build = update_formula.ROOT / "build"
        build.mkdir(exist_ok=True)
        self.temporary = tempfile.TemporaryDirectory(dir=build)
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.formula = self.root / "foundrylocal.rb"
        self.original = update_formula.FORMULA.read_bytes().replace(b"0.13.0", b"0.12.1")
        self.formula.write_bytes(self.original)
        self.archive = self.root / "foundry-0.13.0-osx-arm64.zip"
        with zipfile.ZipFile(self.archive, "w") as package:
            for name in (
                "foundry", "foundrylocald", "libonnxruntime-genai.dylib",
                "libonnxruntime.dylib", "libfoundry_local.dylib", "notices/LICENSE.txt",
            ):
                package.writestr("foundry-cli-osx-arm64/bin/" + name, "test content")
        self.addCleanup(patch.stopall)
        patch.object(update_formula, "FORMULA", self.formula).start()
        patch.object(update_formula, "ROOT", self.root).start()
        patch("sys.stdout", new_callable=io.StringIO).start()

    def test_local_archive_infers_version_and_preserves_installation(self):
        update_formula.main(["--archive", str(self.archive)])
        actual = self.formula.read_bytes()
        expected = self.original
        replacements = {
            "url": (
                "https://github.com/microsoft/Foundry-Local/releases/download/"
                "cli-preview-0.13.0/foundry-0.13.0-osx-arm64.zip"
            ),
            "version": "0.13.0",
            "sha256": hashlib.sha256(self.archive.read_bytes()).hexdigest(),
        }
        for field, value in replacements.items():
            expected = re.sub(
                rb'^  ' + field.encode() + rb' "[^"\r\n]*"',
                f'  {field} "{value}"'.encode(), expected, flags=re.MULTILINE,
            )
        self.assertEqual(actual, expected)

    def test_version_downloads_archive_and_cleans_up(self):
        response = io.BytesIO(self.archive.read_bytes())
        with patch("urllib.request.urlopen", return_value=response) as download:
            update_formula.main(["--version", "0.13.0"])
        self.assertTrue(download.call_args.args[0].endswith(
            "/cli-preview-0.13.0/foundry-0.13.0-osx-arm64.zip"
        ))
        self.assertEqual(list((self.root / "build").iterdir()), [])
        self.assertIn('  version "0.13.0"', self.formula.read_text())

    def test_invalid_arguments_leave_formula_unchanged(self):
        for args in (
            [],
            ["--version", "../invalid"],
            ["--archive", str(self.root / "foundry-0.13.0-linux-x64.zip")],
            ["--version", "0.12.1", "--archive", str(self.archive)],
        ):
            with self.subTest(args=args), contextlib.redirect_stderr(io.StringIO()):
                with self.assertRaises(SystemExit) as error:
                    update_formula.main(args)
                self.assertEqual(error.exception.code, 2)
                self.assertEqual(self.formula.read_bytes(), self.original)

    def test_failed_download_leaves_formula_unchanged_and_cleans_up(self):
        with patch("urllib.request.urlopen", side_effect=urllib.error.URLError("not found")):
            with contextlib.redirect_stderr(io.StringIO()):
                with self.assertRaises(SystemExit) as error:
                    update_formula.main(["--version", "0.13.0"])
        self.assertEqual(error.exception.code, 1)
        self.assertEqual(self.formula.read_bytes(), self.original)
        self.assertEqual(list((self.root / "build").iterdir()), [])

    def test_invalid_archives_leave_formula_unchanged(self):
        for contents in (None, "root/bin/foundry", "root/bin/notices/LICENSE.txt"):
            with self.subTest(contents=contents):
                if contents is None:
                    self.archive.write_bytes(b"not a zip")
                else:
                    with zipfile.ZipFile(self.archive, "w") as package:
                        package.writestr(contents, "incomplete package")
                with contextlib.redirect_stderr(io.StringIO()):
                    with self.assertRaises(SystemExit) as error:
                        update_formula.main(["--archive", str(self.archive)])
                self.assertEqual(error.exception.code, 1)
                self.assertEqual(self.formula.read_bytes(), self.original)

    def test_unexpected_formula_leaves_file_unchanged(self):
        self.formula.write_text('  version "0.12.1"\n')
        original = self.formula.read_bytes()
        with contextlib.redirect_stderr(io.StringIO()):
            with self.assertRaises(SystemExit) as error:
                update_formula.main(["--archive", str(self.archive)])
        self.assertEqual(error.exception.code, 1)
        self.assertEqual(self.formula.read_bytes(), original)


if __name__ == "__main__":
    unittest.main()
