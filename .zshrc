which uname > /dev/null
if [ $? -eq 0 ]; then
    case `uname` in
        "Linux")
            alias ls='ls --color=auto' ;;
        "Darwin")
            alias ls='ls -g';;
        *)
            echo `uname` " is not supported";;
    esac
else
    echo "uname is not available, please report"
fi

alias ll='ls -la'
alias lt='ls -lt'

## histroy
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
test -d `dirname $DIRSTACKFILE` || mkdir -p $DIRSTACKFILE 
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
