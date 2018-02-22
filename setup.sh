#!/bin/bash -e

if [ $(uname -s) == 'Darwin' ]; then
    DISTRIBUTION_ID='macOS'
elif [ $(command -v lsb_release) ]; then
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
        sudo apt-get update -qq
        sudo apt-get install -qq -y cmake zsh vim git ctags build-essential python-dev python3-dev wget curl tmux
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
    macOS)
        echo "In macOS"
        brew install cmake vim macvim
        ;;
    *)
        echo "Unknown distribution $DISTRIBUTION_ID"
        exit -1
        ;;
esac

DOTFILE_ROOT=`pwd`

# install prezto
# https://github.com/sorin-ionescu/prezto
ZPREZTO_ROOT=${ZDOTDIR:-$HOME}/.zprezto
[[ -d $ZPREZTO_ROOT ]] && rm -rf $ZPREZTO_ROOT
git clone --recursive https://github.com/sorin-ionescu/prezto.git $ZPREZTO_ROOT

ZPREZTO_CONF_DIR="${ZDOTDIR:-$HOME}/.zprezto/runcoms/"
for rcfile in $(find $ZPREZTO_CONF_DIR -name 'z*'); do
    echo $rcfile;
    ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.$(basename $rcfile)"
done

# copy over the config files
cp --remove-destination $DOTFILE_ROOT/.zsh-dummy $HOME/.zshrc
ln -sf $DOTFILE_ROOT/prezto/zpreztorc $HOME/.zpreztorc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf

echo 'Done. The main environment has been setup.'
