#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

lxsession &
picom --experimental-backends &
feh --bg-fill --randomize ~/Pictures/wallpapers/Anime/* &
/usr/bin/emacs --daemon &
nm-applet &
copyq &
pa-applet &
