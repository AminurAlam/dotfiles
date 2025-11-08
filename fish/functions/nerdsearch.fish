function nerdsearch -d "better nerdfix serch"
    nerdfix dump --output - 2>/dev/null \
        | jq -r '.icons[]
        | select(.obsolete == false)
        | "   \\\U" + .codepoint + " " + .name' - \
        | string unescape \
        | fzf --query "$argv[1]" \
        | awk '{printf($1)}' \
        | fish_clipboard_copy
end
