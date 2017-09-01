#!/bin/sh

id=$(xdotool search --classname weechat 2>/dev/null)

if [ $? -ne 0 -o -z "$id" ]; then
	urxvt -im weechat -name weechat -title weechat -n weechat \
		-e ~/bin/weechat.sh &
else
	xdotool windowactivate $id
fi
