function dlsort
    # https://github.com/INFU-AV/ChaosCode/blob/main/scripts/dlSorter.sh

    [ -n "$XDG_DOWNLOAD_DIR"      ] && cd "$XDG_DOWNLOAD_DIR" || return

    [ -d "/sdcard/apk/"           ] && command mv -- *.{apk,apks,apkm} "/sdcard/apk/"               &> /dev/null
    [ -d "/sdcard/main/torrents/" ] && command mv -- *.{torrent} "/sdcard/main/torrents/"           &> /dev/null
    [ -d "$XDG_DOCUMENTS_DIR"     ] && command mv -- *.{pdf,epub,htm,html} "$XDG_DOCUMENTS_DIR/"    &> /dev/null
    [ -d "$XDG_PICTURES_DIR"      ] && command mv -- *.{gif,png,webp,jpg,jpeg} "$XDG_PICTURES_DIR/" &> /dev/null
    [ -d "$XDG_MUSIC_DIR"         ] && command mv -- *.{flac,ogg,mp3,opus,m4a} "$XDG_MUSIC_DIR/"    &> /dev/null
    [ -d "$XDG_VIDEOS_DIR"        ] && command mv -- *.{mov,mp4,m4v,avi,webm} "$XDG_VIDEOS_DIR/"    &> /dev/null
end
