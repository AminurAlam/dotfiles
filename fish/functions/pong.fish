function pong
    set -l concurrent 4
    set -f addresses  google.com youtube.com twitter.com wikipedia.org yahoo.com amazon.com live.com reddit.com discord.com twitch.tv $argv

    for address in $addresses

        while [ "$(jobs -c | rg -c --include-zero '^ping$')" -ge "$concurrent" ]
            sleep 0.2
        end

        command ping -qc 10 -i 0.2 -- "$address" | awk '
        /^--- / {
            print "--- " $2 " ---"
        }
        /^10 packets/ {
            print $4"/"$1" in "$10
        }' &
    end

    while [ "$(jobs -c | rg -c --include-zero '^ping$')" -gt 0 ]
       sleep 0.1
    end
end
