function pong
    set -f addresses  google.com youtube.com twitter.com wikipedia.org yahoo.com amazon.com live.com reddit.com discord.com twitch.tv $argv

    for address in $addresses

        while [ (count (jobs)) -gt 3 ]
            sleep 0.2
        end

        command ping -q -c 10 -i 0.2 -- "$address" |
        head -n 4 | tail -n 2 | awk '
        /^--/ { print "--- " $2 " ---" }
        /10/ { print $4"/"$1" in "$10 }' &
    end

    while [ (count (jobs)) -gt 0 ]
       sleep 0.1
    end
end