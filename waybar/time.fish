#!/usr/bin/env -S fish --no-config

while true
    echo
    for stuff in clean sync update
        set file $XDG_STATE_HOME/time_since/$stuff
        test -e $file || continue
        set cur (date +%s)
        set last (date -r $file +%s)
        set delta (math -s0 "($cur - $last) / 3600")

        [ "$delta" -gt (cat $file) ]
        and printf " $stuff:%dh " $delta
    end
    sleep 30
end
