#!/usr/bin/env bash -ex

# do this only once!
# brew tap homebrew/cask-fonts

FONTS="font-inconsolata font-roboto-slab font-lato"

brew cask install $FONTS
