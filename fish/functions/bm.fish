function bm -d "bookmark manager"
    set -l LINK (
        rg --no-filename --replace '' '^https?://(www\.)?' ~/repos/notes/bookmarks \
        | fzf --query "'$argv[1]" \
        | string split ' ' # remove tags from end
    )[1]

    if echo "$LINK" | rg -q '%s'
        echo "$LINK"
        read query -P "  > "
        [ -z "$query" ] && return
        set LINK (string replace '%s' (string escape --style=url "$query") $LINK)
    end

    xdg-open "https://$LINK" & disown
end
