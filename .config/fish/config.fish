# ============================================================
# FISH CONFIGURATION
# ============================================================
# Author      : Touhidul Shawan
# GitHub      : https://github.com/touhidulshawan
# Dotfiles    : https://github.com/touhidulshawan/dotfiles
# Shell       : Fish 
# ============================================================

# ==========================================
# PATH
# ==========================================
fish_add_path -U $HOME/.local/bin


# ==========================================
# SHELL
# ==========================================
set -g fish_greeting
fish_vi_key_bindings


# ==========================================
# ENVIRONMENT VARIABLES
# ==========================================
set -gx TERM xterm-256color
set -gx BROWSER firefox
set -gx TERMINAL /usr/bin/alacritty

set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx GIT_EDITOR /usr/bin/nvim


# ==========================================
# DOTBARE
# ==========================================
set -gx DOTBARE_DIR $HOME/.dotfiles
set -gx DOTBARE_TREE $HOME


# ==========================================
# PIPENV
# ==========================================
set -gx PIPENV_VENV_IN_PROJECT 1


# ==========================================
# FZF
# ==========================================
fzf --fish | source

fzf_configure_bindings --directory=\cf

set -g fzf_preview_dir_cmd "eza --all --color=always --icons"
set -gx FZF_DEFAULT_COMMAND "fd --type file"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark --ansi"
set -gx fzf_fd_opts --hidden --exclude=.git

# ==========================================
# SOURCES
# ==========================================
source $HOME/.config/fish/alias.fish
source $HOME/.config/fish/abbr.fish


# ==========================================
# UTILITIES
# ==========================================
zoxide init fish | source

# MANPAGER
set -gx MANPAGER "nvim +Man!"

# ==========================================
# INTERACTIVE
# ==========================================
if status is-interactive
    colorscript random
end
