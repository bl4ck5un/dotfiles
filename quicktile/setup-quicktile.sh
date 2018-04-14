#!/bin/sh

command -v pip2 >/dev/null || {
    echo "Please install pip2 and try again!"
}

sudo pip2 install https://github.com/ssokolow/quicktile/archive/master.zip
mkdir -p ~/.config && ln -sf $PWD/quicktile.cfg ~/.config/quicktile.cfg

echo "Done."
