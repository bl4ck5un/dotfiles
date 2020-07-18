#!/usr/bin/env bash

set -ex

sudo apt install --yes -qq \
    fonts-firacode \
    fonts-roboto \
    fonts-inconsolata \
    xfonts-terminus \

bash ./get_adobe_fonts_cjk.sh
bash ./get_source_pro_fonts.sh

