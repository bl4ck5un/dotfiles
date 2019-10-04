#!/bin/sh +ex

mkdir -p $HOME/.config/i3
ln -sf $(pwd)/config.base $HOME/.config/i3
ln -sf $(pwd)/i3status.conf $HOME/.config/i3
ln -sf $(pwd)/themes $HOME/.config/i3

test -f ./j4-make-config && ./j4-make-config -r gruvbox

echo "Done."
echo "Please review config.base and tweak"
echo "then refer to README"

echo "Please install fonts-roboto and fonts-font-awesome"
echo "On Ubuntu: sudo apt install fonts-roboto fonts-font-awesome"
