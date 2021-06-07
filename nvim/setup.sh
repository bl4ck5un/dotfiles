#!/bin/bash -e

command -v apt-get && {
    sudo apt-get install --yes \
	python3-dev \
	python3-pip \
	python3-setuptools \
    neovim
}

pip3 install --user -U neovim

mkdir -p ~/.config/nvim
ln -sf $(pwd)/init.vim ~/.config/nvim/init.vim
nvim +PlugClean +PlugUpdate +PlugIn

command -v update-alternatives && {
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
}