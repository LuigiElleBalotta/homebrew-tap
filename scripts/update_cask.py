"""Brings Casks/mcp-hub.rb up to the latest mcp-hub release: version and the
sha256 of both macOS zips. Exits 0 without changes when already current.

    python scripts/update_cask.py            # latest release
    python scripts/update_cask.py 1.1.1      # a given tag
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
import urllib.request
from pathlib import Path

REPO = "LuigiElleBalotta/mcp-hub"
CASK = Path(__file__).resolve().parents[1] / "Casks" / "mcp-hub.rb"
ARCHS = ("arm64", "x86_64")


def fetch(url: str) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": "homebrew-tap-updater"})
    with urllib.request.urlopen(req, timeout=300) as resp:  # noqa: S310 (fixed https host)
        return resp.read()


def latest_tag() -> str:
    data = json.loads(fetch(f"https://api.github.com/repos/{REPO}/releases/latest"))
    return data["tag_name"]


def main() -> int:
    tag = (sys.argv[1] if len(sys.argv) > 1 else latest_tag()).lstrip("v")
    text = CASK.read_text(encoding="utf-8")
    current = re.search(r'^\s*version "([^"]+)"', text, re.M).group(1)
    if current == tag:
        print(f"already at {tag}")
        return 0
    shas = {}
    for arch in ARCHS:
        url = f"https://github.com/{REPO}/releases/download/{tag}/mcp-hub-gui-macos-{arch}.zip"
        try:
            shas[arch] = hashlib.sha256(fetch(url)).hexdigest()
        except Exception as exc:  # a missing asset must not produce a broken cask
            print(f"cannot update to {tag}: {url}: {exc}")
            return 1
    text = re.sub(r'(^\s*version )"[^"]+"', rf'\1"{tag}"', text, count=1, flags=re.M)
    text = re.sub(r'(sha256 arm:\s+)"[0-9a-f]+"', rf'\1"{shas["arm64"]}"', text, count=1)
    text = re.sub(r'(intel:\s+)"[0-9a-f]+"', rf'\1"{shas["x86_64"]}"', text, count=1)
    CASK.write_text(text, encoding="utf-8")
    print(f"updated {current} -> {tag}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
