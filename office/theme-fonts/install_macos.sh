#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="$BASE_DIR/out"

DEST_DIR="$HOME/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Themes.localized/Theme Fonts"

mkdir -p "$DEST_DIR"

shopt -s nullglob
files=("$OUT_DIR"/*.xml)
if [ ${#files[@]} -eq 0 ]; then
  echo "No XML files found in $OUT_DIR" >&2
  exit 1
fi

for f in "${files[@]}"; do
  echo "Install $(basename "$f") -> $DEST_DIR"
  cp -f "$f" "$DEST_DIR/"
done

echo "Done. Quit and reopen Office apps to see the Theme Fonts."
