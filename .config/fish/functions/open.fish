# open file
function open
    set fileName (fd . -Ht f  | fzf)
    if string length -q -- $fileName
        xdg-open $fileName
    end
end
