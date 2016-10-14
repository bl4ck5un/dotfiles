#!/bin/sh -x

sudo apt-get install -y cmake zsh vim git ctags
sudo apt-get install -y build-essential python-dev python3-dev

DOTFILE_ROOT=`pwd`

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
for rcfile in $DOTFILE_ROOT/prezto/*; do ln -sf "$rcfile" "$HOME/.$(basename $rcfile)"; done
cp -f $DOTFILE_ROOT/.zsh-dummy $HOME/.zshrc
source ~/.zshrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
mkdir ~/.vim
ln -sf $(pwd)/vim/ftplugin ~/.vim
ln -sf $(pwd)/vim/plugin ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -sf $(pwd)/.vimrc ~/.vimrc
vim +PluginInstall +qall

pushd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd

chsh
