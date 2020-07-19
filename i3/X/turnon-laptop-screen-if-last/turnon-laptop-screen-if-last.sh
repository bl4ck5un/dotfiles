#!/usr/bin/env bash

set -e

export DISPLAY=:0
export XAUTHORITY=/run/user/1000/gdm/Xauthority

DP1_STATUS=$(</sys/class/drm/card0/card0-DP-1/status)
DP2_STATUS=$(</sys/class/drm/card0/card0-DP-2/status)
DP3_STATUS=$(</sys/class/drm/card0/card0-DP-3/status)

date >> /tmp/here1

echo "$XAUTHORITY" >> /tmp/here1
echo "$DP1_STATUS" >> /tmp/here1
echo "$DP2_STATUS" >> /tmp/here1
echo "$DP3_STATUS" >> /tmp/here1

if [[ "disconnected" == "$DP1_STATUS" && \
    "disconnected" == "$DP2_STATUS" && \
    "disconnected" == "$DP3_STATUS" ]]; then

    echo "entering if" >> /tmp/here1

    /usr/bin/xrandr --output DP-1 --off
    /usr/bin/xrandr --output DP-2 --off
    /usr/bin/xrandr --output DP-3 --off
    /usr/bin/xrandr --output eDP-1 --auto

    echo "exiting if" >> /tmp/here1
fi

echo done >> /tmp/here1
