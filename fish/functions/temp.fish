function temp
    mkdir -p $XDG_CACHE_HOME/temp/
    cd $XDG_CACHE_HOME/temp/

    switch $argv
        case 'fish'; $EDITOR temp.fish
        case 'lua';  $EDITOR temp.lua
        case 'py';   $EDITOR temp.py
        case 'sh';   $EDITOR temp.sh
        case 'txt';  $EDITOR temp.txt
        case 'md';   $EDITOR temp.md
        case '*'
            mkdir -p a/b/c/
            mkdir -p x/y/z/
            touch x/y/z/0
            touch 1
            touch 2
            touch 3
            lt
    end

end
