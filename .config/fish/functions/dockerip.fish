# grab ip address of running docker container
function dockerip
    echo "[?] Container ID: "
    set container_ID (read)
    docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_ID
end
