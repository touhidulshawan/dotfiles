#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

lxsession &
picom --experimental-backends &
# nitrogen --set-zoom-fill --restore &
feh --bg-fill --randomize ~/Pictures/Anime/* &
/usr/bin/emacs --daemon &
nm-applet &
copyq &
pa-applet &
