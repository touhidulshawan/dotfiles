# exports
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
export LESSHISTFILE=-
export HISTFILE="$HOME/.config/bash/.bash_history"
export QT_QPA_PLATFORMTHEME=qt5ct

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


# search github repository & clone it
alias ghs="gh s | xargs gh repo clone"

# alias for docker-compose
# list all running containters
alias dcp="docker compose ps"
# start all containers
alias dcu="docker compose up"
# start all containers, rebuild if necessary
alias dcub="docker compose up --build"
# stop all running containers
alias dcs="docker compose stop"
# stop and remove all containters, networks, images, volumnes
alias dcd="docker compose down --rmi all --volumes"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../..'
alias .5='cd ../../../..'
alias .6='cd ../../../../..'

# alias for my eza command replace for ls
alias la='eza -al --icons --sort=name --color=always --group-directories-first'
alias ls='eza -a --icons --sort=name --group-directories-first'
alias ll='eza -l --icons --color=always --group-directories-first'
alias lt='eza -aT --icons --color=always --group-directories-first'
alias l.='eza -a | egrep "^\."'

#alias for advanced copy
alias cp='uu-coreutils cp -rig'
alias mv='uu-coreutils mv -fig'
alias rm='uu-coreutils rm -frdv'

# aliash for feh
alias fh='feh -g 1024x576 -. *'

# alias for sxiv
alias sx="sxiv -t -g 1338x719 *"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cat='bat'
# [bat as MANPAGER]
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# [nvim as MANPAGER]
export MANPAGER="nvim +Man!"

# alias for exit
alias e='exit'

#alias for clear
alias cl='clear'

# alias for neovim
alias nv='fd -t f | fzf | xargs nvim'

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
alias ytv='yt-dlp  -S "res:1440" --embed-thumbnail --merge-output-format mp4 --split-chapters --write-subs'

# search package and install from pacman
alias add="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias remove="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro doas pacman -Rns"

# remove pacman lock
alias unlock="doas rm /var/lib/pacman/db.lck"

# setup fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# fix tryhackme machine website issues
alias nmfix='doas ip link set dev nm-bridge mtu 1200'
alias tunfix='doas ip link set dev tun0 mtu 1200'

# alias for vagrant
alias vaup='vagrant up --provider=libvirt'

# bare git repo alias for dotfiles
alias config='/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}'
alias cn=config
alias config=dotbare


### ARCHIVE EXTRACTION
ex() {
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


# manage bare repository
source ~/.dotbare/dotbare.plugin.bash
export DOTBARE_DIR="$HOME/.dotfiles"
export DOTBARE_TREE="$HOME"

eval "$(zoxide init bash)"
