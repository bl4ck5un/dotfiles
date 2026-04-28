dotfiles
========

Zsh and Prezto
--------------

The simplest path is to run `./setup.sh` — it installs zsh + tooling for your
distro, clones Prezto into `~/.zprezto`, symlinks the runcoms, copies
`zsh/.zsh-dummy` to `~/.zshrc`, links `zsh/prezto/zpreztorc` to `~/.zpreztorc`,
and sets zsh as the default login shell via `chsh` (skipped on macOS, which
already ships zsh).

### Layout under `zsh/`

    zsh/
    ├── .zshrc                       # main config sourced by ~/.zshrc
    ├── .zsh-dummy                   # template that gets copied to ~/.zshrc
    ├── .zshrc-cachyos               # CachyOS/Arch flavor (eza, bat, pacman aliases, fastfetch)
    ├── .zshrc-go / -python / -rust  # language env setup
    ├── .zshrc-sgx                   # Intel SGX SDK
    ├── .zshrc-zsh-enhancements      # jump + direnv hooks
    ├── setup-zsh-enhancements.sh    # installer for direnv + jump
    └── prezto/zpreztorc             # Prezto module list and config

### Opting into language/distro modules

`~/.zshrc` (which is a copy of `zsh/.zsh-dummy`) sources `zsh/.zshrc` by default
and has commented-out `source` lines for each opt-in module. Uncomment what you
need on a given machine — e.g. on CachyOS:

        source $HOME/dev/dotfiles/zsh/.zshrc-cachyos

### Manual install (if you don't want to run setup.sh)

        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
        for rcfile in "${ZDOTDIR:-$HOME}/.zprezto/runcoms/"z*; do ln -sf "$rcfile" "$HOME/.$(basename $rcfile)"; done
        ln -sf "$HOME/dev/dotfiles/zsh/prezto/zpreztorc" "$HOME/.zpreztorc"
        cp -f "$HOME/dev/dotfiles/zsh/.zsh-dummy" "$HOME/.zshrc"
        source ~/.zshrc

git
---

Resume global git configuration (name, email, etc.) before using it.

    ln -sf $(pwd)/.gitconfig ~/.gitconfig

Vim
---

0. Install latest Vim from brew

        brew install vim

1. Syslink `.vim/ftplugin` and `.vim/plugin`

        mkdir ~/.vim
        ln -sf $(pwd)/vim/ftplugin ~/.vim
        ln -sf $(pwd)/vim/plugin ~/.vim

2. Install [Vundle](https://github.com/gmarik/Vundle.vim)

        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

3. Syslink `.vimrc`
    
        ln -sf $(pwd)/.vimrc ~/.vimrc

4. Install Vim plug-ins

        vim +PluginInstall +qall

5. Compile `YouCompleteMe` before using: 

        cd ~/.vim/bundle/YouCompleteMe
        brew install cmake
        sudo apt-get install build-essential cmake python-dev python3-dev
        ./install.py --clang-completer

6. Install `ctags`:

        brew install ctags
        sudo pacman -Syu ctags


gnome-terminal
---------------

A very good collection of color schemes is found 
[here](https://github.com/metalelf0/gnome-terminal-colors)


    cd /tmp
    git clone git@github.com:metalelf0/gnome-terminal-colors.git
    cd gnome-terminal-colors
    ./install.sh


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
