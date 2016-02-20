if [[ $(uname) == 'Darwin' ]]; then
    plugins=(brew git zsh-syntax-highlighting)
elif [[ $(uname) == 'Linux' ]]; then
    plugins=(git)
fi

export EDITOR='vim'
if [[ $(uname) == 'Darwin' ]]; then
  eval `/usr/libexec/path_helper -s`
  if [[ ! -n $SSH_CONNECTION ]]; then
    export EDITOR='mvim'
  fi
fi

alias shuffle="perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);'"

[[ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]] && \
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
