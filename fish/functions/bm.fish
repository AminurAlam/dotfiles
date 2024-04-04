function bm
    set BMPATH /sdcard/main/notes/bookmarks # /sdcard/main/notes/private-bookmarks
    [ -n "$LAUNCHER" ] || set LAUNCHER fzf
    [ -n "$BROWSER" ] || set BROWSER open

    switch "$argv[1]"
        case a add
            echo "$argv[2]" >>"$BMPATH[1]"
        case e ed edit
            $EDITOR $BMPATH
        case h host
            # TODO: implement custom site
            shiori server &
            disown &>/dev/null
            open http://127.0.0.1:8080
        case '*'
            set -l LINK (
                rg --no-filename --replace '' '^https?://(www\.)?' $BMPATH |
                $LAUNCHER --query "$argv[1]" |
                string split ' '
            )[1]

            if echo "$LINK" | rg -q '%s'
                echo "$LINK" | rg '^(\w+\.)+\w+'
                read query -P "  > "
                [ -z "$query" ] && return
                set LINK (string replace '%s' (string escape --style=url "$query") $LINK)
            end

            [ -z "$LINK" ] && return
            $BROWSER "https://$LINK"
    end
end
