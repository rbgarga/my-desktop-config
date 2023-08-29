set -x

export LANG="en_US.UTF-8"
export LC_COLLATE="C"

xrdb -merge .Xresources

[ -n "$1" ] && wm="$1" || wm=xfce

if echo "$wm" | grep -iq xfce; then
	exec /usr/local/bin/startxfce4 --with-ck-launch
else
	sh ~/bin/display-setup.sh
	#xautolock -locker "i3lock -c 000000" &
	xautolock -locker "xlock -allowroot -usefirst -mode blank" &
	xdg-user-dirs-update &
	clipit &
	#synergys &
	setxkbmap -layout us,us -variant ,intl -option grp:alt_space_toggle -option caps:swapescape &
	feh --bg-fill ~/.wallpaper.jpg &
	xmodmap ~/.Xmodmap &
	exec ck-launch-session $wm
fi
