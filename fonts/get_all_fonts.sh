#!/usr/bin/env bash

set -ex

sudo apt install fonts-inconsolata \
    xfonts-terminus \
    fonts-firacode

bash ./get_adobe_fonts_cjk.sh
bash ./get_source_pro_fonts.sh

