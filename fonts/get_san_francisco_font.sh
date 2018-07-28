#!/usr/bin/env bash

REPO_URL=https://github.com/AppleDesignResources/SanFranciscoFont

tmp_dir=$(mktemp -d)
git clone $REPO_URL $tmp_dir
mkdir -p ~/.fonts && mv $tmp_dir/*.otf ~/.fonts && rm -rf $tmp_dir
