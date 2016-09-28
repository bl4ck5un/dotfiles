# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR='vim'
alias shuffle="perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);'"

[[ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]] && \
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt clobber
