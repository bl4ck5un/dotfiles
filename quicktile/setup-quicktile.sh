#!/bin/sh


command -v pip2 >/dev/null || {
    echo "Please install pip2 and try again!"
}

command -v apt-get > /dev/null || {
    echo "Please install dependencies manually: https://github.com/ssokolow/quicktile"
}

set -e

sudo apt-get update
sudo apt-get install --yes python python-gtk2 python-xlib python-dbus python-wnck python-setuptools

sudo pip2 install https://github.com/ssokolow/quicktile/archive/master.zip
mkdir -p ~/.config && ln -sf $PWD/quicktile.cfg ~/.config/quicktile.cfg

echo "Done."
