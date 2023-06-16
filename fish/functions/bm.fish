function bm
    set HELP_TEXT "usage:
    bm <f|fd|find> [query]  find something with fuzzy search
    bm <g|get> /pattern/    list entries with matching regex pattern
    bm <a|add> <text>       add a new entry
    bm <e|ed|edit>          edit the entries"

    # you can add more paths here
    set BMPATH /sdcard/main/notes/bookmarks.note

    function __process_link
        set -l LINK (string split ' ' "$argv[1]")[1]

        if echo "$LINK" | grep -q '%s'
            printf "  $LINK" | grep -E '^  (\w+\.)+\w+'
            printf "  ╭───────────────────────────────────────────────╮"\n\n
            printf "  ╰───────────────────────────────────────────────╯"
            read query -P \033\[1A"  │   "
            printf \033\[2A"  ╭───────────────────────────────────────────────╮"\n
            printf         "  │   %s%s│"\n $query (string repeat -n (math 43 - (string length "$query")) " ")
            printf         "  ╰───────────────────────────────────────────────╯"\n

            [ -z "$query" ] && return
            set LINK (string replace '%s' (string escape --style=url "$query") $LINK) &
        end
        [ -z "$LINK" ] && return
        $BROWSER "https://$LINK"
        disown $last_pid &>/dev/null
    end

    [ -z "$LAUNCHER" ]
    and if command -vq sk;   set LAUNCHER sk
    else if command -vq fzf; set LAUNCHER fzf
    end

    switch "$argv[1]"
        case f fd find
            __process_link (rg --replace '' '^https?://(www\.)?' $BMPATH | $LAUNCHER --query "$argv[2]")
        case g get
            grep -i --no-filename "$argv[2]" $BMPATH
        case a add
            [ -n "$argv[2]" ] && echo "$argv[2]" >>"$BMPATH" || echo "nothing to add"
        case e ed edit
            set -q EDITOR && $EDITOR $BMPATH || echo "no EDITOR found"
        case c check
            cat $BMPATH | grep '^http' | sort | uniq -c | sort
        case d delete
            echo TODO
        case '*'
            echo $HELP_TEXT
    end
end
