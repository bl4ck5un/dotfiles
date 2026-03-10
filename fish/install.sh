#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/dev/dotfiles/fish/themes"
TARGET_DIR="${HOME}/.config/fish/themes"

mkdir -p "$TARGET_DIR"

for src in "$DOTFILES_DIR"/*; do
  [ -e "$src" ] || continue
  name="$(basename "$src")"
  dst="$TARGET_DIR/$name"

  ln -sfn "$src" "$dst"
  echo "Linked $dst -> $src"
done
