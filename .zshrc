which lsb_release > /dev/null
if [ $? -ne 0 ]; then
    echo "Not Linux(R), assume as Mac OS X"
    alias ls='ls -g'
else
    alias ls='ls --color=auto'
fi

alias ll='ls -l'
alias lt='ls -lt'


HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

## bind keys as Vim
bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit
promptinit
prompt redhat

## Dirstack Configuration
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
test -f $DIRSTACKFILE || touch $DIRSTACKFILE
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
    print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
## This reverts the +/- operators.
setopt pushdminus
