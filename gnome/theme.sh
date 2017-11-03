#!/usr/bin/env bash

mkdir -p ~/.themes/

wget -O /tmp/ant.zip https://github.com/EliverLara/Ant/archive/v1.0.2.zip

pushd ~/.themes
unzip -o /tmp/ant.zip
popd
