function music -d "download and process music" -a url_or_archive password
    cd "$XDG_DOWNLOAD_DIR/music/"

    # download
    if string match -q -- 'http*' "$url_or_archive"
        aria2c "$url_or_archive" || return 1
        set -f archive (path basename "$url_or_archive")
    else if [ -f "$url_or_archive" ]
        set -f archive "$url_or_archive"
    end

    # unzip
    set parent (zipinfo -1 "$archive" | kt / 1 | sort -u)
    set dir (string replace -r -- ' \((ALAC|FLAC)\) .*' '' "$parent")
    [ (count $parent) -gt 1 ] && return 2
    if [ -n "$password" ]
        7z x -bb0 -bso0 -p$password "$archive" || return 3
    else
        7z x -bb0 -bso0 -p(read -P "password: " | rg --only-matching '\w{20}') "$archive" || return 3
    end
    trash-put "$archive"
    mv "$parent" "$dir"
    cd "$dir"

    # converting
    for i in *.m4a
        ffmpeg -y -hide_banner -stats -loglevel error -i "$i" \
            -vn -acodec flac -ar 44100 -sample_fmt s16 \
            (path change-extension flac "$i")
        and rm "$i"
    end

    # cover
    mv cover.jpg cover.orig.jpg
    string split ' - ' "$dir" \
        | string escape --style url \
        | read -L artist album
    wl-copy true
    open "https://covers.musichoarders.xyz/?artist=$artist&album=$album"
    echo "waiting for cover url..."
    while test (wl-paste) = true
        sleep 0.5
    end
    aria2c (wl-paste) -o cover.jpg
    echo

    # tagging
    if [ (count **.flac) -gt 1 ]

        for file in **.flac
            curl -s 'https://lrclib.net/api/search?q=Ado+Shinka' -o lrc.json
            LRCGET v0.2.0 (https://github.com/tranxuanthang/lrcget)
        end
        kid3-cli -c "set picture ''" -c save **.flac

        echo 'running picard...'
        picard -- **.flac &>/dev/null

        echo 'running kid3...'
        kid3-qt -- **.flac &>/dev/null

        kid3-cli \
            -c "set picture ''" \
            -c "fromtag '%{track} %{title}'" \
            -c save **.flac
    else if [ (count *.flac) = 1 ]
        kid3-cli \
            -c "set picture:cover.jpg ''" \
            -c "fromtag '%{artist} - %{title}'" \
            -c save *.flac
    end

    # TODO: lrc
    # set SYLT:'/path/to/lyrics.lrc' 'Lyrics Description'

    cd ..
    [ "$(read -P "send out? [y/N] ")" = y ]
    and ctl send brick "$dir"
end
