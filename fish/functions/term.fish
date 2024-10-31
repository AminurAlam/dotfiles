function term
    set out (ps -xo 'pid,cmd' --no-headers | grep 'fish -[l]$')

    set cur 0
    for i in $out
        set cur (math $cur +1)
        if echo $i | grep "$fish_pid"
            break
        end
    end

    printf "%d/%d\n" "$cur" (count $out)
end
