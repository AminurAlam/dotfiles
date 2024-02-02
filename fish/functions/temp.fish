function temp
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    mkdir -p a/b/c/d dir/{x,y,z}
    touch 1 2 3 dir/0
    lt -L2

    [ "$argv" = "" ] || $EDITOR "temp.$argv"
end
