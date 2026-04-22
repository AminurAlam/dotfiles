function pong -d "mass ping multiple hosts to check connection"
    set addresses \
        discord.com \
        github.com \
        google.com \
        mangadex.org \
        reddit.com \
        twitter.com \
        wikipedia.org \
        youtube.com

    [ -n "$argv" ] && set addresses $argv

    function killorphans -s SIGINT
        pkill ping
    end

    for address in $addresses
        ping -q -c 5 -i 0.2 -- "$address" | awk '
        /^--- / { printf("%s: ", $2) }
        /^[0-9]+ packets/ {
            printf("\033[%dm%d\033[0m/%d in %.2fs\n", ($4<2)?"31":($4<4)?"33":"32", $4, $1, $10/1000)
        }' &
    end

    wait ping
end
