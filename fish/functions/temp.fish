function temp -d "quckly open a testing directory and files"
    cd $XDG_CACHE_HOME/temp/ || return

    if [ -n "$argv" ]
        $EDITOR temp.$argv
    else if command -vq yazi
        y
    end
end
