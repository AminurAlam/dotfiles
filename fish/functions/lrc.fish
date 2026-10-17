function lrc -d "download lrc files form links in json" -a query
    # TODO: get region data
    # TODO: move ttml to destination
    # TODO: copy single ttml download to clipboard
    cd "$XDG_DOWNLOAD_DIR/lrc/" || return

    if [ -n "$query" ]
        open "https://music.apple.com/us/search?term=$query"

        printf "waiting for `album.json`..."
        while not [ -e "album.json" ]
            sleep 0.5
        end
    else if not [ -e "album.json" ]
        set afile (fd 'album.json' cache/ | fzf --preview 'jq . {}')
        and cp "$afile" ./
        or return
    end

    [ "$(read -P 'edit? [y/N] ')" = y ]
    and $EDITOR album.json
    clear

    set album (jq -r '.album' album.json)
    mkdir -p "cache/$album" "$album"

    for track_json in (jq -rc '.tracks[]' album.json)
        printf "%s" "$track_json" | jq -r '(.track_num, .name, .url)' | read -L track_num name url
        set path "$album/$track_num $name"
        printf "%s\n" "$path" "$url"

        if not [ -e "cache/$path.json" ] || [ -e "cache/$path.json" -a (jq -r '.error' "cache/$path.json") = true ]
            # TODO: aria2c
            curl -# -X GET -H 'accept: application/json' -o "cache/$path.json" $url
            sleep 3
        end

        jq -r '(.error, .message)' "cache/$path.json" | read -L error message
        if [ "$error" = true ] || [ "$message" != null ]
            echo "ERROR: $message"
        else
            jq -r .content "cache/$path.json" >"$path.ttml"
        end

        echo
    end

    mv album.json "cache/$album/"
end
