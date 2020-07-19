#!/bin/sh +ex

mkdir -p $HOME/.config/i3
ln -sf $(pwd)/config.base $HOME/.config/i3
ln -sf $(pwd)/i3status.conf $HOME/.config/i3
ln -sf $(pwd)/themes $HOME/.config/i3

echo "Installing Ubuntu deps packages"
sudo apt-get install --yes \
    i3 \
    i3lock \
    xss-lock \
    j4-dmenu-desktop \
    fonts-roboto \
    fonts-firacode \
    fonts-font-awesome \
    xfonts-terminus \
    rofi \
    pasystray \
    brightnessctl

test -f ./j4-make-config && ./j4-make-config

echo "Done."
echo "Please review config.base and tweak."
echo "brightnessctl requries user to be in the video group."
echo "\t sudo usermod -aG video $USER"
