#!/usr/bin/env bash

brightnessctl -m info | cut -d , -f 4 > /tmp/xob