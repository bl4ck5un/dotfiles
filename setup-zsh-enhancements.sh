#!/usr/bin/env bash

set -euo pipefail

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
    sudo apt install -y direnv curl

# Fedora/RHEL
elif [[ "$OS_ID" == "fedora" || "$OS_ID" == "rhel" ]]; then
    echo "Detected Fedora/RHEL"

    echo "Installing direnv..."
    sudo dnf install -y direnv curl

# Arch / CachyOS / Manjaro
elif [[ "$OS_ID" == "cachyos" || "$OS_ID" == "arch" || "$OS_ID" == "manjaro" || "${ID_LIKE:-}" == *"arch"* ]]; then
    echo "Detected Arch-based system ($OS_ID)"

    echo "Installing direnv..."
    sudo pacman -S --needed --noconfirm direnv curl

# Homebrew/macOS
elif command -v brew >/dev/null; then
    echo "Detected Homebrew-based system"

    echo "Installing direnv..."
    brew install direnv curl

# Unsupported
else
    echo "Unsupported system: $OS_ID. Manual installation required."
    exit 1
fi

# Install the latest prebuilt Jump binary without requiring Go.
# The main zsh config already includes ~/.local/bin in PATH.
echo "Installing latest jump..."
curl -fsSL https://raw.githubusercontent.com/gsamokovarov/jump/main/install.sh | \
    INSTALL_DIR="$HOME/.local/bin" VERSION=latest bash

# Enable shell integration once; leave existing customizations intact.
zshrc_path="$HOME/.zshrc"
enhancements_source='source $HOME/dev/dotfiles/zsh/.zshrc-zsh-enhancements'
if ! grep -Fxq "$enhancements_source" "$zshrc_path" 2>/dev/null; then
    printf '\n%s\n' "$enhancements_source" >> "$zshrc_path"
fi
echo 'Jump and direnv enabled in ~/.zshrc. Open a new shell to load them.'
