set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.local/share/gem/ruby/3.0.0/bin $fish_user_paths

# Export
set fish_greeting
fish_vi_key_bindings
set TERM xterm-256color
set BROWSER firefox
set EDITOR "emacsclient -t -a ''"
set VISUAL "emacsclient -c -a emacs"
set GIT_EDITOR "emacsclient -t -a="

# create virtualenv in project folder [pipenv]
set --export PIPENV_VENV_IN_PROJECT 1

fzf_configure_bindings --directory=\cf
set fzf_preview_dir_cmd exa --all --color=always --icons
set fzf_fd_opts --hidden --exclude=.git

### Abbreviations (expanded aliases)
abbr ncm ncmpcpp
abbr pbc pbcopy
abbr pbp pbpaste
abbr py python
abbr bl bluetoothctl
abbr bm bashmount
abbr e exit
abbr cl clear
abbr bt btop
abbr n nvim
abbr up "sudo ip link set dev wlan0 up"
abbr down "sudo ip link set dev wlan0 down"
abbr gpkg 'npm install -g eslint prettier prettier-plugin-toml yarn'
abbr st startx
abbr cn config
abbr tl trash-list
abbr rr trash-restore
abbr td trash-empty

# alias for wifi on/OFF
alias start_wifi='nmcli radio wifi on'
alias stop_wifi='nmcli radio wifi off'

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

# aliash for feh
alias fh='feh -g 1024x576 -. *'

alias cat='bat'

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

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# yt-dlp
alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3  --split-chapters'
alias ytv='yt-dlp  -S "res:1440" --embed-thumbnail --merge-output-format mkv --split-chapters --write-subs'

# [bat as MANPAGER]
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# unlock pacman
alias unlock="sudo rm /var/lib/pacman/db.lck"
# search package and install from pacman
alias add="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"
alias remove="paru -Qq | fzf --multi --preview 'paru -Qi {1}' | xargs -ro sudo paru -Rns"

# alias to fix tryhackme machine website issues
alias nmfix="sudo ip link set dev nm-bridge mtu 1200"
alias tunfix="sudo ip link set dev tun0 mtu 1200"
alias tunshow="sudo ip link show dev tun0"

# alias for vagrant
alias vaup="vagrant up --provider=libvirt"

export FZF_DEFAULT_COMMAND="fd --type file"
export FZF_DEFAULT_OPTS="--layout=reverse-list --border=bold --ansi"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ebdbb2,bg:#282828,hl:#b16286 --color=fg+:#689d6a,bg+:#32302f,hl+:#d3869b --color=info:#d65d0e,prompt:#458588,pointer:#fe8019 --color=marker:#8ec07c,spinner:#cc241d,header:#fabd2f'
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

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

starship init fish | source
zoxide init fish | source
fnm env --use-on-cd | source
