dotfiles
========

Shell
-----

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) is a great framework for
managing `zsh` configuration.

Setup steps:

1. install `zsh` if not installed, 

    ZSH="https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
    sh -c "$(curl -fsSL $ZSH)"

2. symlink `.zshrc`: `ln -sf $(pwd)/.zshrc ~/.zshrc`


Vim
---

1. Install lastest Vim from brew: `brew insatll vim`

2. Install [Vundle](https://github.com/gmarik/Vundle.vim)

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

3. Syslink `.vimrc`: `ln -sf $(pwd)/.vimrc ~/.vimrc`

4. Install Vim plugins: `vim +PluginInstall`

5. Compile `YouCompleteMe` before using: 

    cd ~/.vim/bundle/YouCompleteMe
    brew install cmake
    ./install.sh --clange-completer
