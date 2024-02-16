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
