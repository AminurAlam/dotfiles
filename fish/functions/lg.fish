function lg -d "lazygit wrapper"
    if [ "$USER" = fisher ] && not ssh-add -l &>/dev/null
        ssh-add ~/.ssh/git_ed25519
    end

    if [ -n "$NIRI_SOCKET" ] && [ (niri msg -j focused-window | jq .layout.window_size[0]) != 1920 ]
        ctl toggle_width
        LANG=en_US.UTF-8 lazygit
        [ (niri msg -j focused-window | jq .layout.window_size[0]) = 1920 ]
        and ctl toggle_width
    else
        LANG=en_US.UTF-8 lazygit
    end
    :
end
