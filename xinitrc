xautolock -locker "i3lock -c 000000" &
xdg-user-dirs-update &
xrdb -merge .Xresources
clipit &
#synergys &
setxkbmap -option "caps:swapescape" &
feh --bg-scale ~/.wallpaper.jpg &
xmodmap ~/.Xmodmap &
#synergyc -n x230 172.21.4.119 &
exec ck-launch-session $1
