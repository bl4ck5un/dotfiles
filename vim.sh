#!/bin/bash -e

VIM_EXE=$(which vim)
if [ -z $VIM_EXE -o ! -x $VIM_EXE ]; then
    echo "vim not installed";
    exit;
else
    echo "vim found at $VIM_EXE"
fi

# vim
rm -rf ~/.vim
mkdir -p ~/.vim
ln -sf $(pwd)/vim/ftplugin ~/.vim
ln -sf $(pwd)/vim/plugin ~/.vim
ln -sf $(pwd)/.vimrc ~/.vimrc

vim +PlugIn +qall

echo 'Done. VIM environment has been setup.'
