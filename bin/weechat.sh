#!/bin/sh

export PATH=$PATH:/opt/local/bin
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval $(keychain --eval id_rsa)
xrdb -merge ~/.Xresources
mosh --server=/usr/local/bin/mosh-server myvm -- /home/garga/bin/weechat.sh
