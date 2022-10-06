set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.local/share/gem/ruby/3.0.0/bin $fish_user_paths

# Export
set fish_greeting
fish_vi_key_bindings
set TERM xterm-256color
set BROWSER firefox
set EDITOR "emacsclient -t -a ''"
set VISUAL "emacsclient -c -a emacs"
set GIT_EDITOR "emacsclient -t -a ''"

# create virtualenv in project folder [pipenv]
set --export PIPENV_VENV_IN_PROJECT 1

# set default node version
set --universal nvm_default_version v18.10.0

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
abbr wl wall
abbr wll wall2
abbr n nvim
abbr up "sudo ip link set dev wlan0 up"
abbr down "sudo ip link set dev wlan0 down"
abbr berry 'yarn set version berry'
abbr gpkg 'npm install -g eslint prettier prettier-plugin-toml yarn'
abbr st startx
abbr del "rm -rf"
abbr cn config

# alias for wifi on/OFF
alias start_wifi='nmcli radio wifi on'
alias stop_wifi='nmcli radio wifi off'

# alias to change wallpaper randomly from folders
alias wall='feh --bg-fill --randomize ~/Pictures/Anime/*'
alias wall2='feh --bg-fill --randomize ~/Pictures/wallpapers/Gruvbox/*'

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

# fetch cheat.sh about various utilities
function cheat
    curl cheat.sh/$argv | bat
end

#alias for copy
alias cp='cp -r -g -i'
alias mv='mv -i -g'
alias rm='rm -i'

# aliash for feh
alias fh='feh -g 1024x576 -. *'

alias cat='bat'

# alias for emacs
alias em='/usr/bin/emacs -nw'
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# alias for neovim
alias v='nvim'
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
alias yta-best 'yt-dlp --extract-audio --audio-format best --split-chapters'
alias yta-mp3 'yt-dlp --extract-audio --audio-quality 0 --audio-format mp3  --split-chapters'
alias ytv 'yt-dlp  -S "res:1440" --embed-thumbnail --merge-output-format mkv --split-chapters --write-subs'

# alias to travel directory
alias drama='cd /run/media/shawan/Stuff/Entertainment/Drama'
alias anime='cd /run/media/shawan/My\ Drive/Entertainment/Animes'

# [bat as MANPAGER]
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# pacman and yay
alias pacsyu='sudo pacman -Syu'
alias pacsyyu='sudo pacman -Syyu'
alias yaysua='yay -Sua --noconfirm'
alias yaysyu='yay -Syu --noconfirm'
alias search='yay -Ss'
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

starship init fish | source
