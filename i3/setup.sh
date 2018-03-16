#!/bin/sh

mkdir -p $HOME/.config/i3
ln -sf $(pwd)/config.base $HOME/.config/i3
ln -sf $(pwd)/i3status.conf $HOME/.config/i3
ln -sf $(pwd)/themes $HOME/.config/i3
