#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

lxsession &
picom --experimental-backends &
# feh --bg-fill --randomize ~/Pictures/wallpapers/* &
feh ~/.fehbg &
nm-applet &
copyq &
xfce4-power-manager &
emacs --daemon &
