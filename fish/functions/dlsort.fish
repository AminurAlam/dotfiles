function dlsort

    [ -d "$XDG_DOWNLOAD_DIR" ] && cd "$XDG_DOWNLOAD_DIR" || return

    for file in *
        switch (file -b --mime-type "$file")
            case 'application/zip'
                command mv -v -- "$file" "$XDG_DOWNLOAD_DIR/apk/"
            case 'application/x-bittorrent'
                command mv -v -- "$file" "/sdcard/main/torrents/"
            case 'application/pdf'
                command mv -v -- "$file" "$XDG_DOCUMENTS_DIR/"
            case 'image/*'
                command mv -v -- "$file" "$XDG_PICTURES_DIR/"
            case 'audio/*'
                command mv -v -- "$file" "$XDG_MUSIC_DIR/"
            case 'video/*'
                command mv -v -- "$file" "$XDG_VIDEOS_DIR/"
            case 'inode/directory'
                :
            case '*'
                echo "$file: unknown type"
        end
    end
end
