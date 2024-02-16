# add host to /etc/hosts
function addhost
    echo "$argv[1]  $argv[2]" | doas tee -a /etc/hosts
    cat /etc/hosts
end
