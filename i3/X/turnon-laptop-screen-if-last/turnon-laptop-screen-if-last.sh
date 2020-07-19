#!/usr/bin/env bash

set -e

DP1_STATUS=$(</sys/class/drm/card0/card0-DP-1/status)
DP2_STATUS=$(</sys/class/drm/card0/card0-DP-2/status)
DP3_STATUS=$(</sys/class/drm/card0/card0-DP-3/status)

date >> /tmp/here1

echo "$DP1_STATUS" >> /tmp/here1
echo "$DP2_STATUS" >> /tmp/here1
echo "$DP3_STATUS" >> /tmp/here1

if [[ "disconnected" == "$DP1_STATUS" && \
    "disconnected" == "$DP2_STATUS" && \
    "disconnected" == "$DP3_STATUS" ]]; then

    /usr/bin/xrandr --output DP-1 --off |& logger -t xrandr
    /usr/bin/xrandr --output DP-2 --off |& logger -t xrandr
    /usr/bin/xrandr --output DP-3 --off |& logger -t xrandr
    /usr/bin/xrandr --output eDP-1 --auto |& logger -t xrandr
fi

echo done >> /tmp/here1
