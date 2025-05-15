function temp -d "write it and forget it"
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    count $argv &>/dev/null && $EDITOR "temp.$argv" || lt -L2
end
