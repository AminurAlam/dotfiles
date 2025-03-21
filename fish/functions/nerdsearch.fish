function nerdsearch -d "better nerdfix serch"
    set jqscript '
    .icons[] |
    if .obsolete == false then
        "   \\\U" + .codepoint + " " + .name
    else
        ""
    end'

    nerdfix dump --output - 2>/dev/null \
        | jq -r "$jqscript" - \
        | string unescape \
        | fzf --query "$argv[1]" \
        | awk '{printf($1)}' \
        | fish_clipboard_copy
end
