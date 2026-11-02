#!/usr/bin/env -S fish --no-config

while true
    echo
    for stuff in update sync
        test -e $XDG_CACHE_HOME/.{$stuff}time || continue
        set delta (math (date +%s) - (date -r $XDG_CACHE_HOME/.{$stuff}time +%s))
        [ "$delta" -gt (math 24 x 3600) ]
        and printf "  $stuff:%dh " (math -s0 $delta / 3600)
    end
    sleep 30
end
