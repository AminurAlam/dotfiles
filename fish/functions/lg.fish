function lg -d "lazygit wrapper"
    set -f old_size 0
    set -f new_size 0
    if [ -n "$NIRI_SOCKET" ]
        set -f old_size (niri msg -j focused-window | jq .layout.window_size[0])
        niri msg action set-column-width 100%
        and set -f new_size (niri msg -j focused-window | jq .layout.window_size[0])
    end

    LANG=en_US.UTF-8 lazygit

    [ "$old_size" != "$new_size" ] && niri msg action set-column-width 50%
end
