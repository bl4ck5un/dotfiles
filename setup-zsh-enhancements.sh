#!/usr/bin/env bash


set -euo pipefail

# direnv
sudo apt update && sudo apt install direnv

# jump https://github.com/gsamokovarov/jump
# mac: brew install jump
go get github.com/gsamokovarov/jump
