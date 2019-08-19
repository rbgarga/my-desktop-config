set -x
xrdb -merge .Xresources

[ -n "$1" ] && wm="$1" || wm=i3

if echo "$wm" | grep -iq xfce; then
	exec ck-launch-session $wm
else
	#xautolock -locker "i3lock -c 000000" &
	xautolock -locker "xlock -allowroot -usefirst -mode blank" &
	xdg-user-dirs-update &
	clipit &
	#synergys &
	feh --bg-scale ~/.wallpaper.jpg &
	setxkbmap -layout us,us -variant ,intl -option grp:alt_space_toggle -option caps:swapescape &
	xmodmap ~/.Xmodmap &
	exec ck-launch-session $wm
fi
