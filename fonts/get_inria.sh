#!/usr/bin/env bash

set -e

destdir=$HOME/.local/share/fonts/inria
mkdir -p $destdir

tmpdir=$(mktemp -d /tmp/inria.XXXXXX)
trap "rm -rf $tmpdir" err exit

cd $tmpdir
git clone https://github.com/BlackFoundryCom/InriaFonts.git
cd InriaFonts/fonts/InriaSans/TTF
cp -rfv *.ttf $destdir
fc-cache -v $destdir
