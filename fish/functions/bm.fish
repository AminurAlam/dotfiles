function bm -d "bookmark manager"
    set BMPATH /sdcard/main/notes/bookmarks # /sdcard/main/notes/private-bookmarks
    set -q LAUNCHER || set LAUNCHER fzf
    set -q BROWSER || set BROWSER open

    switch "$argv[1]"
        case a add
            echo "$argv[2]" >>"$BMPATH[1]"
        case e ed edit
            $EDITOR $BMPATH
        case repo
            $BROWSER (for repo in $XDG_PROJECTS_DIR/*
                git -C "$repo" remote --verbose | awk '/push/ {print $2}'
            end | $LAUNCHER)
        case '*'
            set -l LINK (
                rg --no-filename --replace '' '^https?://(www\.)?' $BMPATH |
                $LAUNCHER --query "$argv[1]" |
                string split ' ' # remove tags from end
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
