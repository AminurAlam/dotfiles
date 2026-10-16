function at -d "torrent download helper"
    if [ -z "$argv[1]" ]
        [ (niri msg -j focused-window | jq '.layout.window_size[0]') = 1920 ]
        or niri msg action maximize-window-to-edges
        set -f argv[1] (fd -e torrent | fzf -d3 --height 100% --preview-border line --preview-window right --preview 'aria2c -S {}')
    else if string match -q -- 'magnet:*' "$argv[1]"
        aria2c --bt-save-metadata --bt-metadata-only "$argv[1]"
        set file (echo "$argv[1]" | rg --only-matching '[0-9a-f]{40}').torrent
        [ -e "$file" ]
        and set argv[1] "$file"
        or return
    end
    [ -z "$argv[1]" ] && return 1

    set -f files (aria2c $argv[1] -S | rg '\d+\|' | sed -E 's#\|.*/# #' | fzf --multi | kt 1 | string join ,)

    clear
    printf "%s\n" "torrent: $argv[1]" "outdir: $outdir" "files: $files"

    [ -n "$files" ]
    and aria2c --check-integrity --select-file $files $argv[1]
    or return 1
end
