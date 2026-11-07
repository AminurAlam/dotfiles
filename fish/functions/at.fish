function at -d "torrent download helper"
    if [ -z "$argv[1]" ]
        set -f argv[1] (fd -e torrent | fzf -d3 --height 100% --preview-border line --preview-window right --preview 'aria2c -S {}')
    else if string match -q -- 'magnet:*' "$argv[1]"
        aria2c --bt-save-metadata --bt-metadata-only "$argv[1]"
        set file (echo "$argv[1]" | rg -or '$1' 'btih:([0-9a-f]{40})').torrent
        [ -e "$file" ]
        and set argv[1] "$file"
        or return 1
    end
    [ -z "$argv[1]" ] && return 1

    set -f files (aria2c $argv[1] -S | rg '\d+\|' | sed -E 's#\|.*/# #' | fzf --multi | kt 1 | string join ,)
    [ -z "$files" ] && return 2

    clear
    # aria2c --check-integrity --select-file $files $argv[1]

    set port (random 20000 60000)
    aria2c --enable-rpc --rpc-save-upload-metadata=false --dir . --rpc-listen-port $port &>/dev/null &
    set pid (jobs -lp | rg '\d+')
    sleep 0.5

    set gid (curl -s http://localhost:$port/jsonrpc -d \
        '{"jsonrpc":"2.0","id":"1","method":"aria2.addTorrent","params":[
            "'(base64 -w0 $argv[1])'", [],
            {"select-file":"'$files'","check-integrity":"true"}
        ]}' | jq .result)

    [ "$gid" = null ] && return 3
    [ -z "$gid" ] && return 3

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
    echo "quitting..."

    while :
        set stat (curl -s http://localhost:$port/jsonrpc -d \
            '{"jsonrpc":"2.0","id":"1","method":"aria2.tellStatus", "params": ['$gid']}' \
            | jq -r '.result.status')
        if contains $stat complete removed error
            kill $pid
            break
        else if contains $stat active
            continue
        else
            echo $stat
        end
        sleep 0.5
    end
end
