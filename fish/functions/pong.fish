function pong
    set -f addresses  google.com youtube.com twitter.com wikipedia.org yahoo.com amazon.com live.com reddit.com discord.com twitch.tv $argv
    set awkscript '
/^--- / { print "--- " $2 " ---" }
/^10 packets/ { print $4"/"$1" in "$10 }'

    for address in $addresses
        command ping -qc 10 -i 0.2 -- "$address" | awk "$awkscript" &
    end

    wait ping
end
