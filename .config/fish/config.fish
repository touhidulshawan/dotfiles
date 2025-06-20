set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.cargo/bin $HOME/.local/share/gem/ruby/3.0.0/bin $fish_user_paths

# Export
set fish_greeting
fish_vi_key_bindings
set TERM xterm-256color
set BROWSER firefox
set -x EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x GIT_EDITOR /usr/bin/nvim

# dotbare
set -x DOTBARE_DIR "$HOME/.dotfiles"
set -x DOTBARE_TREE "$HOME"

# create virtualenv in project folder [pipenv]
set --export PIPENV_VENV_IN_PROJECT 1


### FZF ###
# Enables the following keybindings:
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd
fzf --fish | source

# sources
source $HOME/.config/fish/alias.fish
source $HOME/.config/fish/abbr.fish
starship init fish | source
zoxide init fish | source

if status is-interactive
    colorscript random
end
