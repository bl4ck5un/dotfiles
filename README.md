dotfiles
========

Zsh and Prezto
--------------

Setup steps:

0. install `brew` if not installed,

        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

1. Install `zsh` if not installed

        brew install zsh

2. Install oh-my-zsh:

        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

   Then create a new Zsh configuration

        for rcfile in $HOME/dev/dotfiles/prezto/*; do
            ln -s "$rcfile" "$HOME/.$(basename $rcfile)"
        done

4. Create a local `zshrc` copy

        ln -sf $HOME/dev/dotfiles/.zsh-dummy $HOME/.zshrc

4. Take immediate effective

        source ~/.zshrc

git
---

Resume global git configuration (name, email, etc.) before using it.

    ln -sf $(pwd)/.gitconfig ~/.gitconfig

Vim
---

0. Install latest Vim from brew

        brew install vim

1. Syslink `.vim/ftplugin`

        mkdir ~/.vim
        ln -sf $(pwd)/vim/ftplugin ~/.vim

2. Install [Vundle](https://github.com/gmarik/Vundle.vim)

        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

3. Syslink `.vimrc`
    
        ln -sf $(pwd)/.vimrc ~/.vimrc

4. Install Vim plug-ins

        vim +PluginInstall +qall

5. Compile `YouCompleteMe` before using: 

        cd ~/.vim/bundle/YouCompleteMe
        brew install cmake
        ./install.py --clang-completer

6. Install `ctags`:

        brew install ctags
        sudo pacman -Syu ctags


tmux
------

1. Syslink conf

    ln -sf $HOME/dev/dotfiles/.tmux.conf ~/.tmux.conf

iTerm2
------

You can import solarized color scheme if you like.

X
--

1. gtk+ theming

I like the Ceti-2 themes from AUR

    yaourt ceti-2

Then syslink the following configuration files:

    ln -sf /home/fan/dev/dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
    ln -sf /home/fan/dev/dotfiles/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini

See http://wiki.archlinux.org/index.php/GTK%2B for more details. 
