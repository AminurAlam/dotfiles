function bm -d "bookmark manager"
    set BMPATH $XDG_DOCUMENTS_DIR/bookmarks
    set -q LAUNCHER || set LAUNCHER fzf
    set -q BROWSER || set BROWSER open

    switch "$argv[1]"
        case a add
            echo "$argv[2]" >>"$BMPATH[1]"
        case e ed edit
            $EDITOR $BMPATH
        case '*'
            set -l LINK (
                rg --no-filename --replace '' '^https?://(www\.)?' $BMPATH |
                fzf --query "'$argv[1]" |
                string split ' ' # remove tags from end
            )[1]

            if echo "$LINK" | rg -q '%s'
                echo "$LINK" | rg '^(\w+\.)+\w+'
                read query -P "  > "
                [ -z "$query" ] && return
                set LINK (string replace '%s' (string escape --style=url "$query") $LINK)
            end

            [ -z "$LINK" ] && return
            $BROWSER "https://$LINK" & disown
    end
end
