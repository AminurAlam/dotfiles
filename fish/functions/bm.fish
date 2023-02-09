function bm
    set HELP_TEXT "usage:
    bm <f|fd|find> [query]  find something with fuzzy search
    bm <g|get> /pattern/      list entries with matching regex pattern
    bm <a|add> <text>       add a new entry
    bm <e|ed|edit>          edit the entries"

    # you can add more paths here
    set -g BMPATH $HOME/.config/bookmarks /sdcard/main/notes/bookmarks.md

    switch "$argv[1]"
        case f fd find
            set LINK (
                cat $BMPATH | grep '^http' | sort | uniq |
                sed --regexp-extended 's#^https?://(www.)?##' |
                $LAUNCHER --print-query --query "$argv[2]"
            )

            if [ -z "$LINK" ];
                echo "nothing selected"
            else if [ (count $LINK) = 1 ];
                $BROWSER "$WWW_HOME/search?q=$(printf $LINK | string escape --style=url)"
            else if [ (count $LINK) = 2 ];
                $BROWSER "https://$LINK[2]"
            end

        case g get
            grep -i --no-filename "$argv[2]" $BMPATH

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
