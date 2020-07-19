#!/usr/bin/env bash

set -e

REPO=https://github.com/florentc/xob.git
BUILD_DEPS="libx11-dev libconfig-dev"

tmpdir=$(mktemp -d /tmp/xob.XXXXXX)

pushd $tmpdir
sudo apt-get install --yes -qq $BUILD_DEPS
git clone https://github.com/florentc/xob.git
cd xob
make && sudo make install
popd

