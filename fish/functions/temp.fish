function temp -d "quckly open a testing directory and files"
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    if [ -n "$argv" ]
        $EDITOR temp.$argv
    else if command -vq yazi
        y
    end
end
