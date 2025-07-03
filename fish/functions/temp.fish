function temp -d "quckly open a testing directory and files"
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    test -n "$argv" && $EDITOR temp.$argv || lt -L2
end
