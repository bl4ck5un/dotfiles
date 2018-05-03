#!/bin/bash


sudo apt-get install --yes python-dev python-pip python3-dev python3-pip neovim

pip2 install --user -U neovim
pip3 install --user -U neovim

mkdir -p ~/.config/nvim
ln -sf $(pwd)/init.vim ~/.config/nvim/init.vim
nvim +PlugClean +PlugUpdate +Plugin +qall
