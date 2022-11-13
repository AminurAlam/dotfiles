function bm
    set HELP_TEXT "usage:
    bm <f|fd|find> [query]  find something with fuzzy search
    bm <g|get> /regex/      list entries with matching regex pattern
    bm <a|add> <text>       add a new entry
    bm <e|ed|edit>          edit the entries"

    # you can add more paths here
    set -q BMPATH || set -g BMPATH $HOME/.config/bookmarks

    function _bm_find
        if command -sq fzf;       set ff fzf
        else if command -sq sk;   set ff sk
        else if command -sq fzy;  set ff fzy
        else if command -sq pick; set ff pick
        else; echo "skim, fzf, fzy, pick not installed" && return 1
        end

        set LINK (cat $BMPATH | uniq | $ff -q "$argv")

        if [ -n "$LINK" ]
            xdg-open $LINK
        else
            echo "nothing selected $HELP_TEXT"
        end
    end

    function _bm_get
        if command -sq rg;        set grep rg --no-line-number
        else if command -sq grep; set grep grep
        else; echo "grep, ripgrep not installed" && return 1
        end

        if set -q argv
            $grep -i --no-filename "$argv" $BMPATH
        else
            echo "no pattern given $HELP_TEXT"
        end
    end

    function _bm_add
        touch $BMPATH

        if [ -n "$argv" ]
            echo "$argv" >> $HOME/.config/bookmarks
        else
            echo "nothing to add $HELP_TEXT"
        end
    end

    function _bm_edit
        if set -q EDITOR; set EDIT $EDITOR
        else if command -sq vi;   set EDIT vi
        else if command -sq nano; set EDIT nano
        else; echo "editor not installed" && return 1
        end

        $EDIT $BMPATH
    end

    switch "$argv[1]"
        case f fd find; _bm_find $argv[2]
        case g get; _bm_get $argv[2]
        case a add; _bm_add $argv[2]
        case e ed edit; _bm_edit
        case '*'; echo $HELP_TEXT
    end
end
