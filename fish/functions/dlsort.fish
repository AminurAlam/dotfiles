function dlsort

    [ -d "$XDG_DOWNLOAD_DIR" ] && cd "$XDG_DOWNLOAD_DIR" || return

    for file in *
        switch (file -b --mime-type "$file")
            case 'application/zip'
                command mv -- "$file" "/sdcard/apk/"
            case 'application/x-bittorrent'
                command mv -- "$file" "/sdcard/main/torrents/"
            case 'application/pdf'
                command mv -- "$file" "$XDG_DOCUMENTS_DIR/"
            case 'image/*'
                command mv -- "$file" "$XDG_PICTURES_DIR/"
            case 'audio/*'
                command mv -- "$file" "$XDG_MUSIC_DIR/"
            case 'video/*'
                command mv -- "$file" "$XDG_VIDEOS_DIR/"
            case '*'
                echo "$file: unknown type"
        end
    end
end
