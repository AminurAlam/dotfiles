function battery
    set -l old_tty (stty --save)
    stty -echo -icanon min 0

    while [ -z "$key" ]
        set -l current (command cat /sys/class/power_supply/battery/batt_current_ua_now) || break

        [ $current -le 0 ] && set_color red
        [ $current -gt 0 ] && set_color brred
        [ $current -gt 500 ] && set_color bryellow
        [ $current -gt 1000 ] && set_color brgreen
        [ $current -gt 1500 ] && set_color brcyan
        printf '█%.0s' (seq (math -s 0 (tput cols) x $current/2000 ))
        echo
        sleep 0.5
        set key (cat -v)
    end
    stty "$old_tty"
end
