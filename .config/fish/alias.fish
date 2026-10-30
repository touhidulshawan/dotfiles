# Author: Touhidul Shawan

# ==========================================
# DOTFILES (BARE GIT)
# ==========================================
alias config="$HOME/.dotbare/dotbare"

# Push dotfiles to GitHub and Codeberg
alias cpush="config push -u github main && config push -u codeberg main"


# ==========================================
# PACMAN
# ==========================================
# Search and install official repository packages
alias pack="doas pacman -S (pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse)"

# Uninstall installed packages
alias remove="doas pacman -Rns (pacman -Qq | fzf -m --preview 'pacman -Qi {}')"

# Unlock pacman database
alias unlock="doas rm /var/lib/pacman/db.lck"

# List installed native packages
alias archpack="pacman -Qenq"

# List installed AUR packages
alias aurpack="pacman -Qemq"


# ==========================================
# SSH
# ==========================================
alias sk="ssh-add ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_codeberg"


# ==========================================
# NAVIGATION
# ==========================================
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias .6="cd ../../../../../.."


# ==========================================
# EZA (LS REPLACEMENT)
# ==========================================
alias ls="eza -a --icons --sort=name --group-directories-first"
alias l="eza --icons --color=always --group-directories-first"
alias la="eza -al --total-size --icons --sort=name --color=always --group-directories-first"
alias lt="eza -aT --icons --color=always --group-directories-first"


# ==========================================
# COREUTILS
# ==========================================

# Safe operations
alias cp="uu-coreutils cp -rig"
alias mv="uu-coreutils mv -ig"
alias rm="uu-coreutils rm -irg"

# Force operations 
alias cpr="uu-coreutils cp -rfg"
alias mvr="uu-coreutils mv -fg"
alias rmr="uu-coreutils rm -rfg"

# ==========================================
# FILE VIEWERS
# ==========================================
# Feh
alias fh="feh -g 1024x576 -. *"

# Sxiv
alias ii="sxiv ."

# Bat
alias cat="bat"

# Batgrep
alias rg="batgrep"


# ==========================================
# GREP
# ==========================================
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"


# ==========================================
# STORAGE
# ==========================================
alias du="du -sh"
alias ncdu="ncdu --color dark"


# ==========================================
# PROCESS MONITORING
# ==========================================
# Top memory-consuming processes
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"

# Top CPU-consuming processes
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"


# ==========================================
# SYSTEM
# ==========================================
# Show journal errors
alias jctl="journalctl -p 3 -xb"

# Wi-Fi
alias start_wifi="nmcli radio wifi on"
alias stop_wifi="nmcli radio wifi off"

# IP with colors
alias ip="ip -c"

# Keyboard key detection
alias whatkey="wev"

# ==========================================
# FILE SEARCH
# ==========================================
# Search and open files in Neovim
alias nf="fd -Ht f | fzf | xargs -r nvim"

# Search and copy file path
alias getpath="fd . -aHt f | fzf | xclip -selection c"


# ==========================================
# PYTHON / UV
# ==========================================
# Activate project virtual environment
alias uva="source .venv/bin/activate.fish"


# ==========================================
# YOUTUBE-DL
# ==========================================
# Download audio as MP3
alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3 --extractor-args "youtube:player-client=default,-tv_simply"'

# Download video
alias ytv='yt-dlp -S "res:1440" --embed-subs --merge-output-format mp4 --extractor-args "youtube:player-client=default,-tv_simply"'
