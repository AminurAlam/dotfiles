function battery
    while true
        # printf '\x1b[1A'
        # printf '\x1b[2K'
        set -l current (command cat /sys/class/power_supply/battery/batt_current_ua_now)
        or return

        # [ $current -lt 0 ] && set_color red
        [ $current -gt 0 ] && set_color brred
        [ $current -gt 400 ] && set_color bryellow
        [ $current -gt 700 ] && set_color brgreen
        [ $current -gt 1000 ] && set_color brcyan
        printf '█%.0s' (seq (math -s 0 (tput cols) x $current/1200 ))
        echo
        set_color normal
        sleep 0.5
    end

end
