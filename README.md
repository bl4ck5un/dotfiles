dotfiles
========

Shell
-----

Setup steps:

0. install `brew` if not installed,

        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

1. Install `zsh` if not installed

        brew install zsh

2. Install oh-my-zsh:

        sh -c $(curl -fsSL "https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh")

3. copy `.zsh-dummpy` to `~/.zshrc`. (Revised: using a wrapper of the actual `.zshrc` allows better portability)
    
        cp -f .zsh-dummp ~/.zshrc

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


iTerm2
------

You can import solarized color scheme if you like.
