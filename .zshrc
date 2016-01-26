if [[ $(uname) == 'Darwin' ]]; then
    plugins=(brew git zsh-syntax-highlighting)
elif [[ $(uname) == 'Linux' ]]; then
    plugins=(git)
fi

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
if [[ $(uname) == 'Darwin' ]]; then
  eval `/usr/libexec/path_helper -s`
  if [[ ! -n $SSH_CONNECTION ]]; then
    export EDITOR='mvim'
  fi
fi

alias l='ls -l'


alias shuffle="perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);'"

# Virtualenvwrapper
# export WORKON_HOME=~/Envs
# source ~/Library/Python/2.7/bin/virtualenvwrapper.sh 
# source /usr/local/opt/autoenv/activate.sh
#
# play well with gruvbox scheme
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
