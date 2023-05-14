#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

lxsession &
picom --experimental-backends &
# feh --bg-fill --randomize ~/Pictures/wallpapers/anime/* &
~/.fehbg &
nm-applet &
copyq &
pa-applet &
xfce4-power-manager &
emacs --daemon &
