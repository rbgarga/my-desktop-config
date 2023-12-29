set -x

exec 1> ~/.xinitrc.log 2>&1

export LANG="en_US.UTF-8"
export LC_COLLATE="C"

xrdb -merge .Xresources

: ${wm:=i3}

setxkbmap -layout us,us -variant ,intl -option grp:win_space_toggle -option caps:swapescape &
xmodmap ~/.Xmodmap &
xdg-user-dirs-update &

case "$wm" in
	xfce)
		xfce4-clipman &
		exec /usr/local/bin/startxfce4 --with-ck-launch
		;;
	*)
		sh ~/bin/display-setup.sh
		xautolock -locker "xlock -allowroot -usefirst -mode blank" &
		clipit &
		feh --bg-fill ~/.wallpaper.jpg &
		exec ck-launch-session $wm
		;;
esac
