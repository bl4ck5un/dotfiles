#!/usr/bin/env bash

set -euo pipefail

os=""

if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    os="${ID:-}"
fi

case "$os" in
    arch|cachyos)
        sudo pacman -S --needed \
            ttf-firacode-nerd \
            otf-firamono-nerd

        if command -v fc-cache >/dev/null 2>&1; then
            fc-cache -fv
        fi
        ;;
    ubuntu|debian)
        ;;
    fedora)
        ;;
    *)
        ;;
esac
