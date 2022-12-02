function bm
    set HELP_TEXT "usage:
    bm <f|fd|find> [query]  find something with fuzzy search
    bm <g|get> /regex/      list entries with matching regex pattern
    bm <a|add> <text>       add a new entry
    bm <e|ed|edit>          edit the entries"

    # you can add more paths here
    set -q BMPATH || set -g BMPATH $HOME/.config/bookmarks
    touch "$BMPATH"

    function _bm_find
        set -l OPTS --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --border

        if set -q LAUNCHER;       :
        else if command -sq fzf;  set LAUNCHER fzf $OPTS
        else if command -sq sk;   set LAUNCHER sk $OPTS
        else; echo "LAUNCHER not found, try installing skim or fzf" && return 1
        end

        if set -q BROWSER;            :
        else if command -sq open;     set BROWSER open
        else if command -sq xdg-open; set BROWSER xdg-open
        else; echo "BROWSER not found, try installing xdg-open or xdg-utils" && return 1
        end

        set LINK (
            cat "$BMPATH" |
            grep '^http' |
            uniq |
            sed --regexp-extended 's#^https?://(www.)?##' |
            $LAUNCHER --query "$argv"
        )

        [ -n "$LINK" ] &&
            $BROWSER "https://$LINK" ||
            echo "nothing selected"
    end

    switch "$argv[1]"
        case f fd find
            _bm_find $argv[2]

        case g get
            grep -i --no-filename "$argv[2]" "$BMPATH"

        case a add
            [ -n "$argv[2]" ] &&
                echo "$argv[2]" >> "$BMPATH" ||
                echo "nothing to add"

        case e ed edit
            set -q EDITOR &&
                $EDITOR $BMPATH ||
                echo "no EDITOR found"

        case '*'
            echo $HELP_TEXT
    end
end
