# ============================================================
# BASH CONFIGURATION
# ============================================================
# Author      : Touhidul Shawan
# GitHub      : https://github.com/touhidulshawan
# Dotfiles    : https://github.com/touhidulshawan/dotfiles
# Shell       : Bash
# ============================================================

# ============================================================
# ENVIRONMENT VARIABLES
# ============================================================

export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export GIT_EDITOR="/usr/bin/nvim"

export LESSHISTFILE="-"
export HISTFILE="$HOME/.config/bash/.bash_history"

export QT_QPA_PLATFORMTHEME="qt5ct"


# ============================================================
# INTERACTIVE SHELL CHECK
# ============================================================

case "$-" in
    *i*) ;;
    *) return ;;
esac


# ============================================================
# HISTORY
# ============================================================

HISTCONTROL=ignoreboth


# ============================================================
# SHELL OPTIONS
# ============================================================

# Automatically change directory when typing a directory name
shopt -s autocd

# Ignore uppercase/lowercase differences in TAB completion
bind "set completion-ignore-case on"


# ============================================================
# PATH
# ============================================================

[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

export PATH


# ============================================================
# GIT PROMPT
# ============================================================

GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"
GIT_PS1_SHOWUPSTREAM="auto verbose"
GIT_PS1_SHOWCONFLICTSTATE="yes"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_HIDE_IF_PWD_IGNORED="yes"

# Load Git prompt
[[ -f "$HOME/.git-prompt.sh" ]] && source "$HOME/.git-prompt.sh"

# Prompt configuration
__update_prompt() {
    PS1_CMD1="$(__git_ps1 ' (%s)')"
}

PROMPT_COMMAND=__update_prompt

PS1='\W${PS1_CMD1}\n◉ '


# ============================================================
# NAVIGATION ALIASES
# ============================================================

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'


# ============================================================
# EZA (LS REPLACEMENT)
# ============================================================

alias ls='eza -a --icons --sort=name --group-directories-first'
alias la='eza -al --icons --sort=name --color=always --group-directories-first'
alias ll='eza -l --icons --color=always --group-directories-first'
alias lt='eza -aT --icons --color=always --group-directories-first'
alias l.='eza -a | grep "^\."'


# ============================================================
# UU-COREUTILS
# ============================================================

alias cp='uu-coreutils cp -rig'
alias mv='uu-coreutils mv -fig'
alias rm='uu-coreutils rm -irdg'


# ============================================================
# IMAGE VIEWERS
# ============================================================

alias fh='feh -g 1024x576 -. *'
alias ii='sxiv .'


# ============================================================
# TEXT UTILITIES
# ============================================================

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rg='batgrep'

alias cat='bat'

# MANPAGER
export MANPAGER="nvim +Man!"


# ============================================================
# GENERAL ALIASES
# ============================================================

alias e='exit'
alias cl='clear'

# Open files using fd, fzf and Neovim
nv() {
    local file
    file="$(fd -t f | fzf)" || return
    [[ -n "$file" ]] && nvim -- "$file"
}


# ============================================================
# STORAGE
# ============================================================

alias du='du -sh'
alias ncdu='ncdu --color dark'


# ============================================================
# SYSTEM MONITORING
# ============================================================

# Top processes by memory usage
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Top processes by CPU usage
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'


# ============================================================
# JOURNALCTL
# ============================================================

alias jctl='journalctl -p 3 -xb'


# ============================================================
# YT-DLP
# ============================================================

alias yta='yt-dlp --extract-audio --audio-quality 0 --audio-format mp3 --split-chapters'

alias ytv='yt-dlp -S "res:1440" --embed-thumbnail --merge-output-format mp4 --split-chapters --write-subs'


# ============================================================
# PYTHON / UV
# ============================================================

alias uva='source .venv/bin/activate'


# ============================================================
# WINDOW MANAGERS
# ============================================================

alias sw='sway'
alias ns='niri --session'

# ============================================================
# GITNOW 
# ============================================================

source "$HOME/.local/bin/gitnow"

# ============================================================
# DOTFILES MANAGEMENT
# ============================================================

# Bare Git repository
alias config='/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Dotbare
alias cn='dotbare'

# Push dotfiles to GitHub and Codeberg
alias cpush='config push -u github main && config push -u codeberg main'


# ============================================================
# PACMAN
# ============================================================

alias unlock='doas rm /var/lib/pacman/db.lck'


# ============================================================
# FZF
# ============================================================

[[ -f /usr/share/fzf/key-bindings.bash ]] && \
    source /usr/share/fzf/key-bindings.bash

[[ -f /usr/share/fzf/completion.bash ]] && \
    source /usr/share/fzf/completion.bash


# ============================================================
# DOTBARE
# ============================================================

export DOTBARE_DIR="$HOME/.dotfiles"
export DOTBARE_TREE="$HOME"

[[ -f "$HOME/.dotbare/dotbare.plugin.bash" ]] && \
    source "$HOME/.dotbare/dotbare.plugin.bash"


# ============================================================
# ZOXIDE
# ============================================================

command -v zoxide >/dev/null 2>&1 && \
    eval "$(zoxide init bash)"


# ============================================================
# COLOR SCRIPT
# ============================================================

command -v colorscript >/dev/null 2>&1 && colorscript -r
