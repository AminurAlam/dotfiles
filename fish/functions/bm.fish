function bm
    set HELP_TEXT "usage:
    bm <f|fd|find> [query]  find something with fuzzy search
    bm <g|get> /pattern/    list entries with matching regex pattern
    bm <a|add> <text>       add a new entry
    bm <e|ed|edit>          edit the entries"

    # you can add more paths here
    set BMPATH /sdcard/main/notes/bookmarks.note

    switch "$argv[1]"
        case f fd find
            set LINK (
                grep '^http' $BMPATH |
                sed --regexp-extended 's#^https?://(www.)?##' |
                $LAUNCHER --query "$argv[2]")

            if echo $LINK | grep -q '%s'
                echo "  $LINK"
                $BROWSER https://(string replace '%s' (read -fP '  ' | string escape --style=url) $LINK)
            else
                $BROWSER https://$LINK
            end

        case g get
            grep -i --no-filename "$argv[2]" $BMPATH

        case a add
            [ -n "$argv[2]" ] && echo "$argv[2]" >> "$BMPATH" || echo "nothing to add"

        case e ed edit
            set -q EDITOR && $EDITOR $BMPATH || echo "no EDITOR found"

        case c check
            cat $BMPATH | rg '^http' | sort | uniq -c | sort

        case d delete
            echo 'TODO'

        case '*'
            echo $HELP_TEXT
    end
end
