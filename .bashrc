#!/bin/bash

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return ;;
esac
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# auto cd
shopt -s autocd

### PATH
if [ -d "$HOME/.bin" ]; then
	PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# export
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
export SUDO_EDITOR=/usr/bin/nvim

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
alias cp='cp -rivg'
alias mv='mv -ivg'
alias rm='rm -iv'

# aliash for feh
alias fh='feh -g 1024x576 -. *'

# alias for sxiv
alias sx="sxiv -t -g 1280x720 *"

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
alias v='fd -t f | fzf | xargs nvim'
alias vi='nvim'
alias vim='nvim'

# create virtualenv in project folder [pipenv]
export PIPENV_VENV_IN_PROJECT=1

# storage
alias du='du -sh'
alias ncdu='ncdu --color dark'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# get error message from journalctl
alias jctl='journalctl -p 3 -xb'

# yt-dlp
alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3  --split-chapters'
alias ytv='yt-dlp  -S "res:1440" --embed-thumbnail --merge-output-format mkv --split-chapters --write-subs'

# search package and install from pacman
alias add="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"
alias remove="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro sudo paru -Rns"

# remove pacman lock
alias unlock="sudo rm /var/lib/pacman/db.lck"

alias getpath="find -type f | fzf | sed 's/^..//' | tr -d '\n' | xclip -selection c"

# setup fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

export FZF_DEFAULT_COMMAND="fd --type f --color=never"
export FZF_DEFAULT_OPTS=" --height 80% --layout=reverse --border --color=fg:#ebdbb2,bg:#282828,hl:#b16286 --color=fg+:#689d6a,bg+:#32302f,hl+:#d3869b --color=info:#d65d0e,prompt:#458588,pointer:#fe8019 --color=marker:#8ec07c,spinner:#cc241d,header:#fabd2f"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
		export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
		ssh) fzf --preview 'dig {}' "$@" ;;
		*) fzf --preview 'bat -n --color=always {}' "$@" ;;
	esac
}

# fix tryhackme machine website issues
alias nmfix='sudo ip link set dev nm-bridge mtu 1200'
alias tunfix='sudo ip link set dev tun0 mtu 1200'

# alias for vagrant
alias vaup='vagrant up --provider=libvirt'

# bare git repo alias for dotfiles
alias config='/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}'
alias cn=config

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
ff() {
	folderName=$(fd . -Ht d --color=always | fzf)
	if [[ -n "$folderName" ]]; then
		cd "$folderName" || return
	fi
}

# open file
open() {
	filename=$(fd . -Ht f --color=always | fzf)
	if [[ -n "$filename" ]]; then
		xdg-open "$filename"
	fi
}

eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(fnm env --use-on-cd)"
