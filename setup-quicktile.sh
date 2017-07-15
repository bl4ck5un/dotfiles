#!/bin/sh

sudo apt-get install python python-gtk2 python-xlib python-dbus python-wnck
mkdir -p ~/bin
curl -o ~/bin/quicktile.py https://raw.githubusercontent.com/ssokolow/quicktile/master/quicktile.py
chmod u+x ~/bin/quicktile.py
mkdir -p ~/.config && ln -sf $PWD/quicktile.cfg ~/.config/quicktile.cfg
