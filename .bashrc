#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

### PATH
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../..'
alias .5='cd ../../../..'
alias .6='cd ../../../../..'

# alias for my exa command replace for ls
alias la='exa -al --icons --sort=name --color=always --group-directories-first'
alias ls='exa -a --icons --sort=name --group-directories-first'
alias ll='exa -l --icons --color=always --group-directories-first'
alias lt='exa -aT --icons --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

#alias for advanced copy
alias cp='cp -rg'
alias mv='mv -ivg'
alias rmf="rm -rfv"

# aliash for feh
alias fh='feh -g 1024x576 -. *'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cat='bat'
# [bat as MANPAGER]
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# alias for exit
alias e='exit'

#alias for clear
alias cl='clear'

# alias for emacs
alias em='emacsclient -t -a='
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# alias for neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# yt-dlp
alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3  --split-chapters'
alias ytv='yt-dlp  -S "res:1440" --embed-thumbnail --merge-output-format mkv --split-chapters --write-subs'

# remove pacman lock
alias unlock="sudo rm /var/lib/pacman/db.lck"

alias getpath="find -type f | fzf | sed 's/^..//' | tr -d '\n' | xclip -selection c"

export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--layout=reverse --border --ansi"

### ARCHIVE EXTRACTION
extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *.deb) ar x "$1" ;;
            *.tar.xz) tar xf "$1" ;;
            *.tar.zst) unzstd "$1" ;;
            *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# search and go that directory
fcd() {
    filename=$(fd . -Ht d --color=always | fzf)
    if [[ -n "$filename" ]]; then
        cd "$filename" || return
    fi
}

# open file
open() {
    filename=$(fd . -Ht f --color=always | fzf)
    if [[ -n "$filename" ]]; then
        xdg-open "$filename"
    fi
}

del() {
    filename=$(fd . -Ht f --color=always | fzf)
    if [[ -n "$filename" ]]; then
        rm -iv "$filename"
    fi
}
eval "$(starship init bash)"
