#!/bin/sh

echo "$@" >> /tmp/debug

action=$1
cur_vol=$(mixer -S vol | cut -d: -f2)

save_vol() {
	if [ "$cur_vol" = "0" ]; then
		return
	fi

	echo "$cur_vol" > /tmp/.saved_vol
}

restore_vol() {
	local _vol=50
	if [ -f /tmp/.saved_vol ]; then
		_vol=$(cat /tmp/.saved_vol)
	fi

	echo "$_vol"
}

case "$action" in
	up)
		vol="+1"
		;;
	down)
		vol="-1"
		;;
	[0-9]*)
		vol="$action"
		;;
	mute)
		save_vol
		vol="0"
		;;
	unmute)
		vol=$(restore_vol)
		;;
	toggle)
		if [ "$cur_vol" = "0" ]; then
			exec $0 unmute
		else
			exec $0 mute
		fi
		exit 0
		;;
	show)
		echo "$cur_vol"
		exit 0
		;;
	*)
		exit 1
esac

mixer vol "$vol" >/dev/null 2>&1
