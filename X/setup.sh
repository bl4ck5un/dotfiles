#!/bin/bash -e

link_to_home() {
    test -f $(pwd)/$1 || {
        echo "File $1 doesn't exist"
        exit -1
    }
    from=$(pwd)/$1
    to=$HOME
    ln -sf $from $to
    echo "File $from linked to $to"
}

link_to_home .Xresources
link_to_home .xinitrc
