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

# create virtualenv in project folder [pipenv]
set --export PIPENV_VENV_IN_PROJECT 1




set -x DOTBARE_DIR "$HOME/.dotfiles"
set -x DOTBARE_TREE "$HOME"


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

source $HOME/.config/fish/alias.fish
source $HOME/.config/fish/abbr.fish
starship init fish | source
zoxide init fish | source
