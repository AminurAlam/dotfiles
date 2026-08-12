function at -d "torrent download helper"
    if [ -z "$argv[1]" ]
        pushd $XDG_DOWNLOAD_DIR/main/torrents/
        set -f argv[1] $XDG_DOWNLOAD_DIR/main/torrents/(fd -d2 -tf --relative-path . | fzf)
        popd
    else if string match -q -- 'magnet:*' "$argv[1]"
        aria2c --bt-save-metadata --bt-metadata-only "$argv[1]"
        set file (echo "$argv[1]" | rg --only-matching '[0-9a-f]{40}').torrent
        [ -e "$file" ]
        and set argv[1] "$file"
        or return
    end
    [ -z "$argv[1]" ] && return 1

    set -f files (aria2c $argv[1] -S | rg '\d+\|' | sed -E 's#\|.*/# #' | fzf --preview 'aria2c -S {}' --multi | kt 1 | string join ,)

    # TODO: termux specif outdir
    set -f outdir (pwd)
    if [ (path dirname $argv[1] | path basename) = anime ]
        set -f outdir $XDG_VIDEOS_DIR
    else if [ (path dirname $argv[1] | path basename) = manga ]
        set -f outdir $XDG_DOWNLOAD_DIR/manga
    else if string match -- '*/torrents/*' $outdir
        set -f outdir $XDG_DOWNLOAD_DIR
    end

    printf "%s\n" "torrent: $argv[1]" "outdir: $outdir" "files: $files"

    [ -n "$files" ]
    and aria2c --check-integrity --select-file $files --dir $outdir $argv[1]
    or return 1
end
