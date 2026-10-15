function nerdsearch -d "better nerdfix serch"
    uv run --no-project --with nerdfont python -c \
        "for n,i in __import__('nerdfont').icons.items():print(i,n[3:])" \
        | fzf --query "$argv[1]" \
        | kt 1 \
        | fish_clipboard_copy
end
