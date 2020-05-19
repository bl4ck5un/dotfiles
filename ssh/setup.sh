#!/usr/bin/env bash

gocryptfs ~/dev/dotfiles/ssh/secret-keys ~/keys

cp -fv ~/key/config ~/.ssh
cp -fv ~/keys/*.pem ~/.ssh

chmod 400 ~/.ssh/*.pem

umount ~/keys