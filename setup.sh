#!/bin/bash -e

DISTRIBUTION_ID=$(lsb_release -i | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g')

case $DISTRIBUTION_ID in
	openSUSE)
		echo 'In openSUSE'
		sudo zypper install cmake zsh vim git ctags python-devel python3-devel
        sudo zypper install -t pattern devel_basis
		;;
	ubuntu)
		echo 'In ubuntu'
		sudo apt-get install -y cmake zsh vim git ctags build-essential python-dev python3-dev
		;;

	*)
		;;
esac

DOTFILE_ROOT=`pwd`

#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
ZPREZTO_ROOT=${ZDOTDIR:-$HOME}/.zprezto
[[ -d $ZPREZTO_ROOT ]] && rm -rf $ZPREZTO_ROOT
git clone --recursive https://github.com/sorin-ionescu/prezto.git $ZPREZTO_ROOT

for rcfile in $DOTFILE_ROOT/prezto/*; do 
    ln -sf "$rcfile" "$HOME/.$(basename $rcfile)"
done

cp -f $DOTFILE_ROOT/.zsh-dummy $HOME/.zshrc

ln -sf $(pwd)/.gitconfig ~/.gitconfig
mkdir -p ~/.vim
ln -sf $(pwd)/vim/ftplugin ~/.vim
ln -sf $(pwd)/vim/plugin ~/.vim
if [[ -d ~/.vim/bundle/Vundle.vim ]]
then
    pushd ~/.vim/bundle/Vundle.vim/
    git pull
    popd
else
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -sf $(pwd)/.vimrc ~/.vimrc
vim +PluginInstall +qall

pushd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd

echo 'Done. The main environment has been setup.'
