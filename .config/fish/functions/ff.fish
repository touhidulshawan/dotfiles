# function to search and go to selected directory
function ff
    set folderName (fd . -Ht d | fzf)
    if string length -q -- $folderName
        cd $folderName
    end
end
