function lrc -d "download lrc files form links in json" -a album_json
    # TODO: get region data
    # TODO: move ttml to destination
    # TODO: search album and open it in browser
    cd "$XDG_DOWNLOAD_DIR/lrc/" || return
    [ -z "$album_json" ] && set album_json (ls *.json | fzf --height 100% --preview 'jq -r . {}')
    [ -e "$album_json" ] || return

    set album (jq -r '.album' $album_json)
    mkdir -p "cache/$album" "$album"

    for track_json in (jq -rc '.tracks[]' $album_json)
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

    mv $album_json "cache/$album/"
end
