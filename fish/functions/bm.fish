function bm

    if command -sq sk;        set ff sk
    else if command -sq fzf;  set ff fzf
    else if command -sq pick; set ff pick
    else; echo "skim, fzf, pick not installed"
    end

    if command -sq rg;        set grep rg
    else if command -sq grep; set grep grep
    else; echo "grep, ripgrep not installed"
    end

    set BMPATH $HOME/.config/bookmarks $HOME/notes/bookmarks

    switch "$argv[1]"
        case f fd find
            open (cat $BMPATH | $ff -q "$argv[2]")
        case a add +
            touch $HOME/.config/bookmarks
            [ -n "$argv[2]" ] && echo "$argv[2]" >> $HOME/.config/bookmarks
        case *
            echo "-_-"
    end
end
