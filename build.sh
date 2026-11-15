#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
out_dir="$repo_dir/dist"
out_file="$out_dir/llm-selection-translate-for-zotero.xpi"
stage_dir="$(mktemp -d)"
trap 'rm -rf "$stage_dir"' EXIT

mkdir -p "$out_dir"
if command -v xmllint >/dev/null 2>&1; then
  xmllint --noout "$repo_dir/chrome/content/preferences.xhtml"
fi
cp "$repo_dir/bootstrap.js" "$repo_dir/manifest.json" "$repo_dir/prefs.js" "$repo_dir/icon.svg" "$stage_dir/"
mkdir -p "$stage_dir/chrome/content/scripts"
cp "$repo_dir/chrome/content/preferences.xhtml" "$stage_dir/chrome/content/"
cp "$repo_dir/chrome/content/scripts/llmselectiontranslate.js" "$stage_dir/chrome/content/scripts/"

rm -f "$out_file"
if command -v zip >/dev/null 2>&1; then
  (
    cd "$stage_dir"
    zip -qr "$out_file" bootstrap.js chrome icon.svg manifest.json prefs.js
  )
else
  python3 - "$stage_dir" "$out_file" <<'PY'
import os
import sys
import zipfile

stage_dir, out_file = sys.argv[1], sys.argv[2]
entries = ["bootstrap.js", "chrome/content/preferences.xhtml",
           "chrome/content/scripts/llmselectiontranslate.js",
           "icon.svg", "manifest.json", "prefs.js"]
with zipfile.ZipFile(out_file, "w", zipfile.ZIP_DEFLATED) as zf:
    for entry in entries:
        zf.write(os.path.join(stage_dir, entry), entry)
PY
fi

echo "Built $out_file"
unzip -l "$out_file"
