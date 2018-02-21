#!/bin/bash

mkdir -p ~/.config/nvim
ln -sf $(pwd)/init.vim ~/.config/nvim/init.vim

nvim +PlugClean +PlugUpdate +Plugin +qall
