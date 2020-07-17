#!/bin/bash -e

# Userland mode (~$USER/), (~/).

FONT_HOME=~/.local/share/fonts
ADOBE_FONT_HOME="$FONT_HOME/adobe-fonts"

echo "Installing adboe fonts to $ADOBE_FONT_HOME"

mkdir -p $ADOBE_FONT_HOME

download_from_github() {
    TMP_DIR=$(mktemp -d)
    pushd $TMP_DIR
    git clone \
       --branch release \
       --depth 1 \
       "https://github.com/adobe-fonts/$1"

    mkdir -p $ADOBE_FONT_HOME/$1
    cp -f $1/OTF/*.otf $ADOBE_FONT_HOME/$1
    popd
    rm -rf $TMP_DIR
}

download_from_github source-code-pro
download_from_github source-sans-pro
download_from_github source-serif-pro

fc-cache -fv $ADOBE_FONT_HOME
