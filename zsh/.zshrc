# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR='vim'

# useful alias
alias shuffle="perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);'"
# https://superuser.com/questions/288320/whats-like-osxs-pbcopy-for-linux
if [[ -n "$WAYLAND_DISPLAY" ]] && command -v wl-copy >/dev/null; then
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste'
else
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

if ! command -v open >/dev/null; then
  alias open='xdg-open'
fi

[[ -f "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh" ]] && \
    source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

setopt clobber
# Upgrade bare 'xterm' to 256-color variant; leave alacritty/kitty/tmux/etc alone.
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  eval "$(ssh-agent -s)"
  ssh-add -q
fi

if [[ "$OSTYPE" == darwin* ]]; then
  preexec() { timer=$SECONDS }
  precmd() {
    if [[ $? -ne 0 && $((SECONDS - timer)) -gt 3 ]]; then
      afplay /System/Library/Sounds/Basso.aiff
    fi
  }
fi
