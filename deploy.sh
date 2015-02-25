#!/bin/bash

# deploy dotfiles to initialize a basic development environment

# overwrite .vimrc
vimrc="$HOME/.vimrc"
[ -f $vimrc ] && {
    mv $vimrc $vimrc.bak
}
cp -f vim/.vimrc $vimrc

# overwrite .gitconfig
gitconf="$HOME/.gitconfig"
[ -f $gitconf ] && {
    mv $gitconf $gitconf.bak
}
cp -f git/.gitconfig $gitconf

# install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
