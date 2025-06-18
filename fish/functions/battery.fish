function battery -d "charging current status"
    # set -l capacity (command cat /sys/class/power_supply/battery/capacity)
    # set -l old_tty (stty --save)
    # stty -echo -icanon min 0
    #
    # while [ -z "$key" ]
    #     set -l current (command cat /sys/class/power_supply/battery/batt_current_ua_now) || break
    #
    #     [ $current -le 0 ] && set_color red
    #     [ $current -gt 0 ] && set_color brred
    #     [ $current -gt 500 ] && set_color bryellow
    #     [ $current -gt 1000 ] && set_color brgreen
    #     [ $current -gt 1500 ] && set_color brcyan
    #     printf '█%.0s' (seq (math -s 0 (tput cols) x $current/2000 ))
    #     echo
    #     sleep 0.5
    #     set key (cat -v)
    # end
    # stty "$old_tty"
    # set_color normal
    # printf "%d -> %d\n" "$capacity" (command cat /sys/class/power_supply/battery/capacity)
    while :
        set current (rish -c 'dumpsys battery' \
            | rg 'current now: .*' \
            | tr -dc [:digit:])
        [ $current -le 0 ] && set_color red
        [ $current -gt 0 ] && set_color brred
        [ $current -gt 500 ] && set_color bryellow
        [ $current -gt 1000 ] && set_color brgreen
        [ $current -gt 1500 ] && set_color brcyan
        # printf "\033[A"
        printf '\033[1000D'
        printf ' %.0s' (seq (tput cols))
        printf '\033[1000D'
        printf '█%.0s' (seq (math -s 0 (tput cols) x $current/2000 ))
        # echo
    end
end
