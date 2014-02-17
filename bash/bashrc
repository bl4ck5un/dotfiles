## history
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


which uname > /dev/null
if [ $? -eq 0 ]; then
    case `uname` in
        "Linux")
            echo "On Linux" 
            echo `uname -a`
            alias ls='ls --color=auto'
            alias ll='ls -alF'
            alias lt='ls -lt'
            alias grep='grep --color=auto'
            # network & stuffs at Intel
            source .bashrc.intel
            ;;
        "Darwin")
            echo "On Mac OS X"
            alias ls='ls -G'
            alias ll='ls -la'
            alias lt='ls -lt'
            alias grep="grep --color=auto"
            ;;
        *)  
            echo `uname` " is not supported";;
    esac
else
    echo "uname is not available, please report"
fi

## some more universal alias
alias rm='rm -i'
alias mv='mv -i'
