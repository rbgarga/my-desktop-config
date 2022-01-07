#!/bin/sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if tmux ls | grep -q '^weechat:' 2>/dev/null; then
 CMD="tmux attach-session -d -t weechat"
else
 CMD="tmux new -s weechat weechat"
fi

$CMD
