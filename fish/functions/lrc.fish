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
        set track_data (printf "%s" "$track_json" | jq -r '(.track_num, .name, .url)')
        set path "$album/$track_data[1..2]"
        set url "$track_data[3]"
        printf "%s\n" "$path"
        # echo $url

        if not [ -e "cache/$path.json" ] || [ -e "cache/$path.json" -a (jq -r '.error' "cache/$path.json") = true ]
            curl -# -X GET -H 'accept: application/json' -o "cache/$path.json" $url
            sleep 3
        end

        set lrc_data (jq -r '(.error, .message)' "cache/$path.json") # >"$path.ttml"
        if [ "$lrc_data[1]" = true ] || [ "$lrc_data[2]" != null ]
            echo "ERROR: $lrc_data[2]"
        else
            jq -r .content "cache/$path.json" >"$path.ttml"
        end

        # if not rg --only-matching 'timing=[^>]+' "$path.ttml"
        #     echo "ERROR: not properly formatted"
        #     rm "$path.ttml"
        # else
        #     # prettier --parser html -w "$path.ttml"
        # end
        echo
    end

    mv album.json "cache/$album/"
end
