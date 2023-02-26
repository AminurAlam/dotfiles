function ping
    set -f addresses  google.com youtube.com twitter.com wikipedia.org yahoo.com amazon.com live.com reddit.com github.com discord.com

    for address in $addresses
        command ping -q -c 10 -i 1 -- "$address" |
        head -n 4 | tail -n 2 | awk '
        /^--/ { print "--- " $2 " ---" }
        /10/ { print $4"/"$1" in "$10 }' &
    end

    while [ (count (jobs)) -gt 0 ]
       sleep 0.2
    end
end
