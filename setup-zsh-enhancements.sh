#!/usr/bin/env bash

set -euo pipefail

# Version of jump to install
JUMP_VER="0.51.0"

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
else
    OS_ID="unknown"
fi

# Ubuntu/Debian
if [[ "$OS_ID" == "ubuntu" || "$OS_ID" == "debian" ]]; then
    echo "Detected Ubuntu/Debian"

    echo "Installing direnv..."
    sudo apt update
    sudo apt install -y direnv

    echo "Installing jump..."
    if command -v go >/dev/null; then
        go install github.com/gsamokovarov/jump@v${JUMP_VER}
    else
        curl -LO "https://github.com/gsamokovarov/jump/releases/download/v${JUMP_VER}/jump_${JUMP_VER}_amd64.deb"
        sudo dpkg -i "jump_${JUMP_VER}_amd64.deb"
        rm "jump_${JUMP_VER}_amd64.deb"
    fi

# Fedora/RHEL
elif [[ "$OS_ID" == "fedora" || "$OS_ID" == "rhel" ]]; then
    echo "Detected Fedora/RHEL"

    echo "Installing direnv..."
    sudo dnf install -y direnv

    echo "Installing jump..."
    if command -v go >/dev/null; then
        go install github.com/gsamokovarov/jump@v${JUMP_VER}
    else
        curl -LO "https://github.com/gsamokovarov/jump/releases/download/v${JUMP_VER}/jump-${JUMP_VER}-1.x86_64.rpm"
        sudo dnf install -y "jump-${JUMP_VER}-1.x86_64.rpm"
        rm "jump-${JUMP_VER}-1.x86_64.rpm"
    fi

# Arch / CachyOS / Manjaro
elif [[ "$OS_ID" == "cachyos" || "$OS_ID" == "arch" || "$OS_ID" == "manjaro" || "${ID_LIKE:-}" == *"arch"* ]]; then
    echo "Detected Arch-based system ($OS_ID)"

    echo "Installing direnv..."
    sudo pacman -S --needed --noconfirm direnv

    echo "Installing jump..."
    if command -v go >/dev/null; then
        go install github.com/gsamokovarov/jump@v${JUMP_VER}
    elif command -v paru >/dev/null; then
        paru -S --needed --noconfirm jump
    elif command -v yay >/dev/null; then
        yay -S --needed --noconfirm jump
    else
        echo "No Go compiler or AUR helper found. Install Go, or install jump from AUR: https://aur.archlinux.org/packages/jump"
    fi

# Homebrew/macOS
elif command -v brew >/dev/null; then
    echo "Detected Homebrew-based system"

    echo "Installing direnv..."
    brew install direnv

    echo "Installing jump..."
    if command -v go >/dev/null; then
        go install github.com/gsamokovarov/jump@v${JUMP_VER}
    else
        echo "No Go compiler found. Please install Go or install jump manually from https://github.com/gsamokovarov/jump"
    fi

# Unsupported
else
    echo "Unsupported system: $OS_ID. Manual installation required."
fi

