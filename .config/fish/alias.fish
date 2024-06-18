# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
# setup dotbare to make manage bare repo easy
alias dotbare="$HOME/.dotbare/dotbare"
alias config=dotbare

# vscodium
alias vs='vscodium .'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../..'
alias .5='cd ../../../..'
alias .6='cd ../../../../..'

# eza like ls
alias la='eza -al --total-size --icons --sort=name --color=always --group-directories-first'
alias ls='eza -a --icons --sort=name --group-directories-first'
alias l='eza --icons --color=always --group-directories-first'
alias lt='eza -aT --icons --color=always --group-directories-first'

# copy, move, remove 
alias cp='uu-coreutils cp -rig'
alias mv='uu-coreutils mv -fig'
alias rm='uu-coreutils rm -frdv'

# feh
alias fh='feh -g 1024x576 -. *'

# sxiv
alias sx="sxiv -t -g 1338x719 *"

# bat like cat
alias cat='bat'

# batgrep like ripgrep 
alias rg='batgrep'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# storage
alias du='du -sh'
alias ncdu='ncdu --color dark'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# search & open with neovim
alias nf='fd -Ht f | fzf | xargs nvim'

# nvim as MANPAGER
export MANPAGER="nvim +Man!"

# getpath
alias getpath="fd . -aHt f | fzf | xclip -selection c"

# unlock pacman
alias unlock="doas rm /var/lib/pacman/db.lck"
# search package and install from pacman
alias add="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias remove="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro doas pacman -Rns"

# yt-dlp
alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3 --write-thumbnail --convert-thumbnails jpg'
alias ytv='yt-dlp  -S "res:1440" --embed-subs --merge-output-format mp4'

# fzf
fzf_configure_bindings --directory=\cf
set fzf_preview_dir_cmd eza --all --color=always --icons
set fzf_fd_opts --hidden --exclude=.git
export FZF_DEFAULT_COMMAND="fd --type file"
export FZF_DEFAULT_OPTS="--layout=reverse-list --border=bold --ansi"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ebdbb2,bg:#282828,hl:#b16286 --color=fg+:#689d6a,bg+:#32302f,hl+:#d3869b --color=info:#d65d0e,prompt:#458588,pointer:#fe8019 --color=marker:#8ec07c,spinner:#cc241d,header:#fabd2f'

# alias for wifi on/OFF
alias start_wifi='nmcli radio wifi on'
alias stop_wifi='nmcli radio wifi off'

# ip with colors
alias ip="ip -c"

# alias to fix tryhackme machine website issues
alias enfix="doas ip link set dev eno1 mtu 1200"
alias nmfix="doas ip link set dev nm-bridge mtu 1200"
alias tunfix="doas ip link set dev tun0 mtu 1200"
alias tunshow="doas ip link show dev tun0"

# alias for vagrant
alias vaup="vagrant up --provider=libvirt"

# search github repository & clone it
alias ghs="gh s | xargs gh repo clone"

# Docker compose 
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
