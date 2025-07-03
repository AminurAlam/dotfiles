function battery -d "charging current status"
    while :
        set current (rish -c 'dumpsys battery' \
            | rg 'current now: .*' \
            | tr -dc [:digit:])
        [ $current -le 0 ] && set_color red
        [ $current -gt 0 ] && set_color brred
        [ $current -gt 500 ] && set_color bryellow
        [ $current -gt 1000 ] && set_color brgreen
        [ $current -gt 1500 ] && set_color brcyan
        printf '\033[1000D'
        printf ' %.0s' (seq (tput cols))
        printf '\033[1000D'
        printf '█%.0s' (seq (math -s 0 (tput cols) x $current/2000 ))
    end
end
