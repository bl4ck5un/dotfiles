#!/usr/bin/env bash


set -euo pipefail

# direnv
sudo apt update && sudo apt install direnv


# jump https://github.com/gsamokovarov/jump
if command -v go > /dev/null; then
    get github.com/gsamokovarov/jump
else
    wget https://github.com/gsamokovarov/jump/releases/download/v0.30.1/jump_0.30.1_amd64.deb && sudo dpkg -i jump_0.30.1_amd64.deb
fi
