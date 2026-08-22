function lrc -d "download lrc files form links in json" -a query
    # TODO: get region data
    # TODO: move ttml to destination
    # TODO: copy single ttml download to clipboard
    cd "$XDG_DOWNLOAD_DIR/lrc/" || return

    [ -n "$query" ]
    and open "https://music.apple.com/us/search?term=$query"

    printf "waiting for `album.json`..."
    while not [ -e "album.json" ]
        sleep 0.5
    end
    [ "$(read -P 'edit? [y/N] ')" = y ]
    and $EDITOR album.json
    clear

    set album (jq -r '.album' album.json)
    mkdir -p "cache/$album" "$album"

    for track_json in (jq -rc '.tracks[]' album.json)
        set data (printf "%s" "$track_json" | jq -r '(.track_num, .name, .url)')
        set path "$album/$data[1..2]"
        set url "$data[3]"
        printf "%s\n" "$path"
        # echo $url

        if not [ -e "cache/$path.json" ] || [ "$(read -P 'already cached, download anyway? [y/N] ')" = y ]
            curl -# -X GET -H 'accept: application/json' -o "cache/$path.json" $url
            sleep 1
        end

        # sed -E 's@>@&\n@g'
        jq -r '.content' "cache/$path.json" >"$path.ttml"
        rg --only-matching 'timing=[^>]+' "$path.ttml"
        echo
    end

    mv album.json "cache/$album/"
end
