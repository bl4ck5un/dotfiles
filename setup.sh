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
        sudo zypper install cmake zsh vim git python-devel python3-devel wget curl
        sudo zypper install -t pattern devel_basis
        ;;
    Ubuntu | Neon | Pop | pop)
        echo 'In Ubuntu | Neon | Pop!_OS'
        sudo apt-get update
        sudo apt-get install -y cmake zsh vim git build-essential python3-dev wget curl tmux
        ;;
    arch)
        echo "In Arch"
        sudo pacman -Syu --needed cmake zsh vim git ctags wget curl python python-pip
        ;;
    Fedora)
        echo "In Fedora"
        sudo dnf install @development-tools cmake zsh vim git ctags python-devel python3-devel \
            gcc-c++ gcc wget curl \
	    yp-tools
        ;;
    cachyos)
        echo "In CachyOS"
        sudo pacman -Syu --needed cmake zsh vim git ctags wget curl python python-pip
        ;;
    macOS)
        echo "In macOS"
        brew install make vim
        ;;
    *)
        echo "Unknown distribution $DISTRIBUTION_ID"
        exit -1
        ;;
esac

# Set zsh as the default login shell (idempotent; skipped on macOS, which already ships zsh).
if [ "$DISTRIBUTION_ID" != "macOS" ]; then
    ZSH_PATH=$(command -v zsh) || { echo "zsh not installed; skipping chsh"; ZSH_PATH=""; }
    if [ -n "$ZSH_PATH" ]; then
        # Ensure /etc/shells lists zsh — chsh refuses otherwise.
        if ! grep -qx "$ZSH_PATH" /etc/shells 2>/dev/null; then
            echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
        fi

        CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
        if [ "$CURRENT_SHELL" = "$ZSH_PATH" ]; then
            echo "zsh is already the default shell"
        else
            # Try chsh; fall back to usermod (avoids password prompt under sudo).
            echo "changing shell to $ZSH_PATH"
            if ! chsh -s "$ZSH_PATH"; then
                echo "chsh failed, falling back to usermod"
                sudo usermod -s "$ZSH_PATH" "$USER"
            fi
            echo "Default shell set to zsh (log out and back in to take effect)."
        fi
    fi
fi

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
test -f $HOME/.zshrc && rm -f $HOME/.zshrc
cp $DOTFILE_ROOT/zsh/.zsh-dummy $HOME/.zshrc
ln -sf $DOTFILE_ROOT/zsh/prezto/zpreztorc $HOME/.zpreztorc
ln -sf $DOTFILE_ROOT/.gitconfig ~/.gitconfig
ln -sf $DOTFILE_ROOT/tmux/.tmux.conf ~/.tmux.conf

echo 'Done. The main environment has been setup.'
