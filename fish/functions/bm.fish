complete -c bm -fka '(rg --replace "" \'^https?://(www\.)?\' /sdcard/main/notes/bookmarks.note)'

function bm
    set BMPATH /sdcard/main/notes/bookmarks /sdcard/main/notes/private-bookmarks

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
        case a add
            [ -n "$argv[2]" ] && echo "$argv[2]" >>"$BMPATH[1]" || echo "nothing to add"
        case e ed edit
            set -q EDITOR && $EDITOR $BMPATH || echo "no EDITOR found"
        case '*'
            __process_link (rg --no-filename --replace '' '^https?://(www\.)?' $BMPATH | $LAUNCHER --query "$argv[1]")
    end
end
