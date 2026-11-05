function at -d "torrent download helper"
    if [ -z "$argv[1]" ]
        [ (niri msg -j focused-window | jq '.layout.window_size[0]') = 1920 ]
        or niri msg action maximize-window-to-edges
        set -f argv[1] (fd -e torrent | fzf -d3 --height 100% --preview-border line --preview-window right --preview 'aria2c -S {}')
    else if string match -q -- 'magnet:*' "$argv[1]"
        aria2c --bt-save-metadata --bt-metadata-only "$argv[1]"
        set file (echo "$argv[1]" | rg -or '$1' 'btih:([0-9a-f]{40})').torrent
        [ -e "$file" ]
        and set argv[1] "$file"
        or return
    end
    [ -z "$argv[1]" ] && return 1

    set -f files (aria2c $argv[1] -S | rg '\d+\|' | sed -E 's#\|.*/# #' | fzf --multi | kt 1 | string join ,)
    [ -z "$files" ] && return

    clear
    # aria2c --check-integrity --select-file $files $argv[1]

    set port (random 20000 60000)
    aria2c --enable-rpc --dir /tmp --rpc-listen-port $port &>/dev/null &
    sleep 0.5

    curl -s http://localhost:$port/jsonrpc -d \
        '{"jsonrpc":"2.0","id":"1","method":"aria2.addTorrent","params":[
            "'(base64 -w0 $argv[1])'", [],
            {"dir": "'$PWD'","select-file":"'$files'","check-integrity":"true"}
        ]}' | jq .result | read -L gid

    [ "$gid" = null ] && return
    [ -z "$gid" ] && return

    printf "%s\n" "torrent: $argv[1]" "files: $files"
    printf "%s\n" "port: $port" "gid: $gid"

    while :
        clear
        curl -s http://localhost:$port/jsonrpc -d \
            '{"jsonrpc":"2.0","id":"1","method":"aria2.tellStatus", "params": ['$gid']}' \
            | jq -rf ~/repos/dotfiles/scripts/torrent.jq || break
        # TODO: different buttons do different things
        # d: debug
        # p: pause
        # s: reselect files
        # a: add files
        timeout 1 fish -c fish_key_reader 2>/dev/null | rg -q "bind q 'do something'"
        and break
    end

    curl -s http://localhost:$port/jsonrpc -d \
        '{"jsonrpc":"2.0","id":"1","method":"aria2.remove", "params": ['$gid']}' >/dev/null

    while :
        curl -s http://localhost:$port/jsonrpc -d \
            '{"jsonrpc":"2.0","id":"1","method":"aria2.tellStatus", "params": ['$gid']}' \
            | jq -r '.result.status' | read -L stat
        if contains $stat complete removed error
            kill (pgrep -f "^aria2c --enable-rpc --dir /tmp --rpc-listen-port $port\$")
            break
        else if contains $stat active
            continue
        else
            echo $stat
        end
        sleep 0.5
    end
end
