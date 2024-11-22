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
        | fzf \
        | awk '{printf($1)}' \
        | termux-clipboard-set
end
