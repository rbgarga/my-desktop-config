#!/bin/sh
if ! xrandr --listmonitors 2>/dev/null | grep -q HDMI; then
	xrandr --output HDMI-1 --off
else
	xrandr --newmode "2560x1080_50.00"  188.75  2560 2712 2976 3392  1080 1083 1093 1114 -hsync +vsync
	xrandr --addmode HDMI-1 2560x1080_50.00
	xrandr --output VGA-1 --off --output LVDS-1 --primary --mode 1366x768 --pos 280x1080 --rotate normal --output HDMI-3 --off --output HDMI-2 --off --output HDMI-1 --mode 2560x1080_50.00 --pos 0x0 --rotate normal --output DP-3 --off --output DP-2 --off --output DP-1 --off

fi
