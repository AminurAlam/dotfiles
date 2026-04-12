function at -d "torrent download helper"
    if [ -z "$argv[1]" ]
        pushd $XDG_DOWNLOAD_DIR/main/torrents/
        set -f argv[1] $XDG_DOWNLOAD_DIR/main/torrents/(fd -d2 -tf --relative-path . | fzf)
        popd
    end
    [ -z "$argv[1]" ] && return 1

    set -f files (aria2c $argv[1] -S | rg '\d+\|' | sed -E 's#\|.*/# #' | fzf --multi | kt 1 | string join ,)

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
    and aria2c --select-file $files --dir $outdir $argv[1]
    or return 1
end
