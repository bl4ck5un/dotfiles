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


# https://github.com/junegunn/fzf/wiki/examples
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

[[ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]] && \
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt clobber
export TERM=xterm-256color

RUST_ENV=$HOME/.cargo/env
CARGO_BIN=$HOME/.cargo/bin


test -f $RUST_ENV && source $RUST_ENV
test -d $CARGO_BIN && export PATH=$PATH:$CARGO_BIN

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
