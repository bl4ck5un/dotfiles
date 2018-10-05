#!/usr/bin/env bash

caskBasePath="$( brew --prefix )/Caskroom"

function __clean-cask
{
  # split $1 into an array
  IFS=' ' read -ra caskArray <<< "$1"

  local cask="${caskArray[0]}"
  local caskDirectory="${caskBasePath}/${cask}"

  # slicing: array:startIndex:length ; exclude first and last elements
  local versionsToRemove=("${caskArray[@]:1:${#caskArray[@]}-2}")

  if [[ -n ${versionsToRemove} ]]; then
    for versionToRemove in "${versionsToRemove[@]}"; do
      echo "Removing ${cask} ${versionToRemove}..."
      rm -fr "${caskDirectory}/${versionToRemove}"
      rm -fr "${caskDirectory}/.metadata/${versionToRemove}"
    done
  fi
}

if [[ $# -eq 0 ]]; then
  while read cask; do
    __clean-cask "${cask}"
  done <<< "$( brew cask list --versions )"
else
  __clean-cask "$1"
fi
