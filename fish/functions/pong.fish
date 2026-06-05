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
        ping -q -c 5 -i 0.5 -- "$address" &
    end | awk '
        /^--- / {
            printf("%14s: ", $2)
        }
        /^[0-5] packets/ {
            printf("\033[%dm%d\033[0m/%d\n", ($4<2)?"31":($4<4)?"33":"32", $4, $1)
        }
        /^送信パケット数 [0-5]/ {
            printf("\033[%dm%d\033[0m/%d\n", ($4<2)?"31":($4<4)?"33":"32", $4, $2)
        }'
end
