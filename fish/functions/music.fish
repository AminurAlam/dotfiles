function music -d "download and process music" -a url_or_archive password
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
            (path change-extension flac "$i" | sed -E 's/^([0-9]+)\. /\1 /')
        and rm "$i"
    end

    # cover
    rm -f cover.jpg
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
    echo 'running picard...'
    picard -- **.flac &>/dev/null

    echo 'running kid3...'
    kid3-qt -- **.flac &>/dev/null

    # TODO: lrc

    cd ..
    [ "$(read -P "send out? [y/N] ")" = y ]
    and ctl send brick "$dir"
end
