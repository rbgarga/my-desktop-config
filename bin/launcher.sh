#!/bin/sh

echo "$@" >> /tmp/my-debug

classname="$1"
run="$2"
workspace="$3"
terminal="$4"

[ -z "$classname" ] && exit 0
[ -z "$run" ] && exit 0

id=$(xdotool search --classname $classname 2>/dev/null | head -n 1)

if [ $? -ne 0 -o -z "$id" ]; then
	if [ -n "$terminal" ]; then
		urxvt -im $classname -name $classname -title $classname \
		    -n $classname -e $run &
	else
		$run &
	fi

else
	if [ -n "$workspace" ]; then
		i3-msg "workspace $workspace"
	else
		xdotool windowactivate $id
	fi
fi
