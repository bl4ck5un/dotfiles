#!/usr/bin/env bash

set -euo pipefail

echo ">> Detecting OS..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
else
    OS_ID="unknown"
fi

echo ">> Installing dependencies for $OS_ID..."

if [[ "$OS_ID" == "ubuntu" || "$OS_ID" == "debian" ]]; then
    sudo apt update
    sudo apt install -y \
        python3-dev \
        python3-pip \
        python3-setuptools \
        neovim
elif [[ "$OS_ID" == "fedora" || "$OS_ID" == "rhel" ]]; then
    sudo dnf install -y \
        python3-devel \
        python3-pip \
        python3-setuptools \
        neovim
else
    echo "Unsupported OS for automatic Neovim setup."
    exit 1
fi

echo ">> Installing Python Neovim plugin..."
pip3 install --user -U neovim

echo ">> Setting up Neovim config..."
mkdir -p ~/.config/nvim
ln -sf "$(pwd)/init.vim" ~/.config/nvim/init.vim

echo ">> Installing Neovim plugins..."
nvim +PlugClean +PlugUpdate +PlugInstall +qall

echo ">> Updating editor alternatives..."
if command -v update-alternatives > /dev/null; then
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
else
    echo ">> Skipping update-alternatives (not available)"
fi

echo "✅ Neovim setup complete!"
