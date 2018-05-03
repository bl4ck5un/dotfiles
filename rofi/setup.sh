#!/usr/bin/env bash

set -e

CONFIG_DIR=$HOME/.config/rofi

mkdir -p $CONFIG_DIR
ln -sf $PWD/rofi.conf $CONFIG_DIR/config
