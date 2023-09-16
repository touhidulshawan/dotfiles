set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.local/share/gem/ruby/3.0.0/bin $fish_user_paths

# Export
set fish_greeting
fish_vi_key_bindings
set TERM xterm-256color
set BROWSER firefox
set -x EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x GIT_EDITOR /usr/bin/nvim

# create virtualenv in project folder [pipenv]
set --export PIPENV_VENV_IN_PROJECT 1

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


# alias for wifi on/OFF
alias start_wifi='nmcli radio wifi on'
alias stop_wifi='nmcli radio wifi off'

# alias for ip
alias ip="ip -c"

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
alias l='exa --icons --color=always --group-directories-first'
alias lt='exa -aT --icons --color=always --group-directories-first'

#alias for copy
alias cp='cp -rivg '
alias mv='mv -ivg'
alias rm='rm -rfv'

# alias for feh
alias fh='feh -g 1024x576 -. *'

# alias for sxiv
alias sx="sxiv -t -g 1338x719 *"

alias cat='bat'

# alias for neovim
alias nf='fd -Ht f | fzf | xargs nvim'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# batgrep
alias rg=batgrep

# storage
alias du='du -sh'
alias ncdu='ncdu --color dark'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# yt-dlp
alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3'
alias ytv='yt-dlp  -S "res:1440" --embed-thumbnail --merge-output-format mp4 --write-subs'

# [nvim as MANPAGER]
export MANPAGER="nvim +Man!"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# unlock pacman
alias unlock="doas rm /var/lib/pacman/db.lck"
# search package and install from pacman
alias add="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias remove="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro doas pacman -Rns"

# alias to fix tryhackme machine website issues
alias enfix="doas ip link set dev eno1 mtu 1200"
alias nmfix="doas ip link set dev nm-bridge mtu 1200"
alias tunfix="doas ip link set dev tun0 mtu 1200"
alias tunshow="doas ip link show dev tun0"

# alias for vagrant
alias vaup="vagrant up --provider=libvirt"

# fzf
fzf_configure_bindings --directory=\cf
set fzf_preview_dir_cmd exa --all --color=always --icons
set fzf_fd_opts --hidden --exclude=.git
export FZF_DEFAULT_COMMAND="fd --type file"
export FZF_DEFAULT_OPTS="--layout=reverse-list --border=bold --ansi"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ebdbb2,bg:#282828,hl:#b16286 --color=fg+:#689d6a,bg+:#32302f,hl+:#d3869b --color=info:#d65d0e,prompt:#458588,pointer:#fe8019 --color=marker:#8ec07c,spinner:#cc241d,header:#fabd2f'

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
# setup dotbare to make manage bare repo easy
alias dotbare="$HOME/.dotbare/dotbare"
alias config=dotbare
set -x DOTBARE_DIR "$HOME/.dotfiles"
set -x DOTBARE_TREE "$HOME"

alias getpath="fd . -aHt f | fzf | xclip -selection c"

# search and go to that directory
function ff
    set folderName (fd . -Ht d | fzf)
    if string length -q -- $folderName
        cd $folderName
    end
end

# function to query zoxide and cd to it
function zz
    set folderPath (zoxide query -l | fzf --reverse)
    if string length -q -- $folderPath
        cd $folderPath
    end
end

# open file
function open
    set fileName (fd . -Ht f  | fzf)
    if string length -q -- $fileName
        xdg-open $fileName
    end
end

# select file/s||/folder/s and trash
function del
    set folderNames (fd . -H | fzf -m)
    if string length -q -- $folderNames
        for item in $folderNames
            trash-put $item
            echo "$item moved to trash" || exit
        end
    end
end

# fetch cheat.sh about various utilities
function cheat
    curl cheat.sh/$argv | bat
end

# grab ip address of running docker container
function dockerip
    echo "[?] Container ID: "
    set container_ID (read)
    docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_ID
end

# add host to /etc/hosts
function addhost
    echo "$argv[1]  $argv[2]" | doas tee -a /etc/hosts
    cat /etc/hosts
end

source $HOME/.config/fish/abbr.fish
starship init fish | source
zoxide init fish | source
