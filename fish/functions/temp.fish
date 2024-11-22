function temp -d "write it and forget it"
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    mkdir -p dir/{1,2}
    touch 1 2 3 dir/0

    count $argv &>/dev/null && $EDITOR "temp.$argv" || lt -L2
end
