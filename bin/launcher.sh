#!/bin/sh

focus() {
	local _rc=0

	if [ "${param}" = "xdotool" ]; then
		local _idx=""
		local _id=""
		for _idx in $(xdotool search --name ${classname} 2>&1); do
			if xprop -id ${_idx} | grep -q _NET_WM_DESKTOP; then
				_id=$_idx
				break
			fi
		done
		if [ -z "${_id}" ]; then
			return 1
		fi
		xdotool windowactivate ${_id} >/dev/null 2>&1
		_rc=$?
	else
		if i3-msg "[${param}=\"${classname}\"] focus" 2>&1 \
		    | grep -q ERROR; then
			_rc=1
		fi
	fi

	return $_rc
}

unset classname param run terminal
while getopts c:t:C:Tx: flag; do
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
		x)
			classname=$OPTARG
			param="xdotool"
			;;
		*)
			echo "ERROR"
			exit 1
	esac
done

[ -z "$classname" ] && exit 0
[ -z "$run" ] && exit 0

if ! focus; then
	if [ -n "$terminal" ]; then
		urxvt -im $classname -name $classname -title $classname \
		    -n $classname -e $run &
	else
		$run &
	fi
	sleep 1
	focus
fi
