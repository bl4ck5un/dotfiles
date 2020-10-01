# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR='vim'

# useful alias
alias shuffle="perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);'"
# https://superuser.com/questions/288320/whats-like-osxs-pbcopy-for-linux
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

[[ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]] && \
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt clobber
export TERM=xterm-256color

export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# set up direnv
# https://direnv.net/docs/hook.html
eval "$(direnv hook zsh)"
