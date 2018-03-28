#!/bin/sh

command -v pip2 || {
    echo "Please install pip2 and try again!"
}

mkdir -p ~/.config && ln -sf $PWD/quicktile.cfg ~/.config/quicktile.cfg
