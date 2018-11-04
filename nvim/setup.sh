#!/bin/bash

command -v apt-get && {
    sudo apt-get install --yes python-dev python-pip python3-pip python3-dev python3-pip \
        python-setuptools python3-setuptools \
        neovim
}

pip2 install --user -U neovim
pip3 install --user -U neovim

mkdir -p ~/.config/nvim
ln -sf $(pwd)/init.vim ~/.config/nvim/init.vim
nvim +PlugClean +PlugUpdate +PlugIn +qall

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
