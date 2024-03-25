function temp
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    mkdir -p dir/{a,b}
    touch 1 2 3 dir/0

    count $argv &>/dev/null && $EDITOR "temp.$argv" || lt -L2
end
