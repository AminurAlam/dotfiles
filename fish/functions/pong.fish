function pong
    set -f addresses \
        amazon.com \
        discord.com \
        github.com \
        google.com \
        live.com \
        reddit.com \
        twitch.tv \
        twitter.com \
        wikipedia.org \
        yahoo.com \
        youtube.com \
        $argv

    set awkscript '
/^--- / { printf("%s: ", $2) }
/^[0-9]+ packets/ {
    printf("\033[%dm%d\033[0m/%d in %.2fs\n", ($4<5)?"31":($4<9)?"33":"32", $4, $1, $10/1000)
}'

    for address in $addresses
        ping -q -c 10 -i 0.2 -- "$address" | awk "$awkscript" &
    end

    wait ping
end
