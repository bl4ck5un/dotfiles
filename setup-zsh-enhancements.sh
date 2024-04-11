#!/usr/bin/env bash


set -euo pipefail

# direnv
if command -v apt-get > /dev/null; then
    sudo apt update && sudo apt install direnv
fi


if command -v brew > /dev/null; then
    brew install direnv
fi


# jump https://github.com/gsamokovarov/jump
if command -v go > /dev/null; then
    go install github.com/gsamokovarov/jump@latest
else
    wget https://github.com/gsamokovarov/jump/releases/download/v0.30.1/jump_0.30.1_amd64.deb && sudo dpkg -i jump_0.30.1_amd64.deb
fi
