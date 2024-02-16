# function to query zoxide and cd to it
function zz
    set folderPath (zoxide query -l | fzf --reverse)
    if string length -q -- $folderPath
        cd $folderPath
    end
end
