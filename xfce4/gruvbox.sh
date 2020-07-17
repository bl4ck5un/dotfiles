#!/usr/bin/env bash


DIR="${XDG_DATA_HOME:-$HOME/.local/share}/xfce4/terminal/colorschemes"

set -e
trap "rm -rf yyy" EXIT ERR
git clone https://github.com/morhetz/gruvbox-contrib.git yyy

echo "Copying .theme files to $dir ..."
mkdir -p "$DIR"
cp yyy/xfce4-terminal/*.theme $DIR
echo "done."
