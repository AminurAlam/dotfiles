function temp
    mkdir -p $XDG_CACHE_HOME/temp/ && cd $XDG_CACHE_HOME/temp/ || return

    switch $argv
        case 'fish'; $EDITOR temp.fish
        case 'lua';  $EDITOR temp.lua
        case 'py';   $EDITOR temp.py
        case 'sh';   $EDITOR temp.sh
        case 'txt';  $EDITOR temp.txt
        case 'md';   $EDITOR temp.md
        case '*'
            mkdir -p a/b/c/d dir/{x,y,z}
            touch 1 2 3 dir/0
            lt
    end

end
