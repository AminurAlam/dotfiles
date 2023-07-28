function fetch
    printf "%s: %s\n" \
        kernel "$(uname -sr)" \
        os "$(uname -o)" \
        arch "$(uname -m)" \
        uptime "$(uptime -p)" \
        packages "$(count (pacman -Qdq))"
end
