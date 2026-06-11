function lg -d "lazygit wrapper"
    if [ -n "$NIRI_SOCKET" ] && [ (niri msg -j focused-window | jq .layout.window_size[0]) != 1920 ]
        ctl toggle-width
        LANG=en_US.UTF-8 lazygit
        [ (niri msg -j focused-window | jq .layout.window_size[0]) = 1920 ]
        and ctl toggle-width
    else
        LANG=en_US.UTF-8 lazygit
    end
    :
end
