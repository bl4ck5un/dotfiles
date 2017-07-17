#!/bin/bash -e

if [ $(command -v lsb_release) ]; then
    DISTRIBUTION_ID=$(lsb_release -i | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g')
elif [ -f /etc/system-release ]; then
    DISTRIBUTION_ID=$(cat /etc/system-release | awk '{print $1}')
else
    DISTRIBUTION_ID=$(basename $(ls -1 /etc/*-release | grep -v os) | awk -F '-' '{print $1}')
fi

case $DISTRIBUTION_ID in
	openSUSE)
		echo 'In openSUSE'
		sudo zypper install cmake zsh vim git ctags python-devel python3-devel wget curl
        sudo zypper install -t pattern devel_basis
		;;
	Ubuntu | neon)
		echo 'In Ubuntu | Neon'
		sudo apt-get install -y cmake zsh vim git ctags build-essential python-dev python3-dev \
            wget curl
		;;
    arch)
        echo "In Arch"
        sudo pacman -Syu --needed cmake zsh vim git ctags wget curl
        ;;
    Fedora)
        echo "In Fedora"
        sudo dnf install @development-tools cmake zsh vim git ctags python-devel python3-devel \
            gcc-c++ gcc wget curl
        ;;
	*)
        echo "Unknown distribution $DISTRIBUTION_ID"
        exit -1
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

# vim
rm -rf ~/.vim
mkdir -p ~/.vim
ln -sf $(pwd)/vim/ftplugin ~/.vim
ln -sf $(pwd)/vim/plugin ~/.vim
ln -sf $(pwd)/.vimrc ~/.vimrc

vim +PlugIn +qall

pushd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer
popd

ln -sf $(pwd)/.tmux.conf ~/.tmux.conf

echo 'Done. The main environment has been setup.'


