function compile -d "run compile scripts"
    set script (ls -1AN ~/repos/dotfiles/scripts/compile/ | path change-extension '' | fzf --query "$argv[1]")
    [ -n "$script" ] && fish "$HOME/repos/dotfiles/scripts/compile/$script.fish"
end
