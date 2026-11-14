function lrc -d "download lrc files form links in json"
    # TODO: move ttml to destination
    # TODO: disc numbering
    cd "$XDG_DOWNLOAD_DIR/lrc/" || return

    if [ -n "$argv[1]" ] && [ -f "$argv[1]" ]
        cp "$argv[1]" ./
    else if not [ -e "album.json" ]
        set afile (fd 'album.json' cache/ | fzf --preview 'jq . {}')
        and cp "$afile" ./
        or return
    end

    # [ "$(read -P 'edit? [y/N] ')" = y ]
    # and $EDITOR album.json

    set album (jq -r '.album' album.json)
    mkdir -p "cache/$album" "$album"

    for track_json in (jq -rc '.tracks[]' album.json)
        printf "%s" "$track_json" | jq -r '(.track_num, .name, .url)' | read -L track_num name url
        set path "$album/$track_num $name"
        printf "%s " "$track_num" "$name"

        if not [ -e "cache/$path.json" ] \
                || rg -q '^error code: ' "cache/$path.json" \
                || jq -e .error "cache/$path.json" >/dev/null
            curl -s -A 'Morphe/9.30.53' -o "cache/$path.json" $url
            sleep 3
        end

        if rg -q '^error code: ' "cache/$path.json" \
                || jq -e .error "cache/$path.json" >/dev/null
            printf "\033[38;5;1mERROR\033[0m\n"
        else if [ -e "$path.ttml" ]
            printf "\033[38;5;2mCACHED\033[0m\n"
        else if jq -r .content "cache/$path.json" >"$path.ttml"
            printf "\033[38;5;2mDONE\033[0m\n"
        end
    end

    mv album.json "cache/$album/"
end
