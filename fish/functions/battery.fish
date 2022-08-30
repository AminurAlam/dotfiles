function battery
    while [ ! ]
        # printf '\x1b[1A'
        # printf '\x1b[2K'
        set -l current (command cat /sys/class/power_supply/battery/batt_current_ua_now)
        set -l count (math -s 0 (tput cols) x abs\($current\)/1400 )

        [ $current -lt 0 ] && set_color red
        [ $current -gt 0 ] && set_color grey
        [ $current -gt 500 ] && set_color yellow
        [ $current -gt 800 ] && set_color green
        [ $current -gt 1000 ] && set_color cyan
        printf '\x1b[2K'
        printf '\x1b[100D'
        printf '█%.0s' (seq $count)
        set_color normal
        sleep 1
    end

end
