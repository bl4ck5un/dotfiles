#!/usr/bin/env bash

mkdir -p ~/.themes/

wget -O /tmp/ant.zip https://github.com/EliverLara/Ant/archive/v1.1.0.zip

pushd ~/.themes
unzip -o /tmp/ant.zip
popd
