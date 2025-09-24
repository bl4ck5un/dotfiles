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

if ! command -v open >/dev/null; then
  alias open='xdg-open'
fi

[[ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]] && \
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt clobber
export TERM=xterm-256color

export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  eval "$(ssh-agent -s)"
  ssh-add -q
fi
