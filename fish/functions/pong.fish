function pong
    set -f addresses google.com youtube.com twitter.com wikipedia.org yahoo.com amazon.com live.com reddit.com discord.com twitch.tv $argv
    set awkscript '
/^--- / { printf("%s: ", $2) }
/^[0-9]+ packets/ { printf("%d/%d in %.2fs\n", $4, $1, $10/1000) }'

    for address in $addresses
        ping -q -c 10 -i 0.2 -- "$address" | awk "$awkscript" &
    end

    wait ping
end
