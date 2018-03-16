#!/bin/sh

mkdir -p $HOME/.config/i3
ln -sf $(pwd)/config $HOME/.config/i3
ln -sf $(pwd)/i3status.conf $HOME/.config/i3
