#!/usr/bin/env bash

set -euo pipefail

if [ $(uname -s) == 'Darwin' ]; then
    DISTRIBUTION_ID='macOS'
elif [ $(command -v lsb_release) ]; then
    DISTRIBUTION_ID=$(lsb_release -i | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g')
elif [ -f /etc/system-release ]; then
    DISTRIBUTION_ID=$(cat /etc/system-release | awk '{print $1}')
else
    DISTRIBUTION_ID=$(basename $(ls -1 /etc/*-release | grep -v os) | awk -F '-' '{print $1}')
fi

case $DISTRIBUTION_ID in
    Ubuntu | Neon)
        sudo apt update && sudo apt install direnv
        go get github.com/gsamokovarov/jump
        ;;
    macOS)
        echo "In macOS"
        brew install direnv jump
        ;;
    *)
        echo "Unknown distribution $DISTRIBUTION_ID"
        exit -1
        ;;
esac
