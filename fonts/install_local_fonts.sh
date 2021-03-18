#!/usr/bin/env bash

set -e

destdir=$HOME/.local/share/fonts
mkdir -p $destdir

cp -rfv *.ttf *.otf $destdir
