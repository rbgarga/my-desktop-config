#!/bin/sh

unset classname param run terminal
while getopts c:t:C:T flag; do
	case ${flag} in
		c)
			classname=$OPTARG
			param="class"
			;;
		t)
			classname=$OPTARG
			param="title"
			;;
		C)
			run=$OPTARG
			;;
		T)
			terminal=1
			;;
		*)
			echo "ERROR"
			exit 1
	esac
done

[ -z "$classname" ] && exit 0
[ -z "$run" ] && exit 0

if i3-msg "[${param}=\"${classname}\"] focus" 2>&1 | grep -q ERROR; then
	if [ -n "$terminal" ]; then
		urxvt -im $classname -name $classname -title $classname \
		    -n $classname -e $run &
	else
		$run &
	fi
fi
