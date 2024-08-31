function clean
    set -f __dirs \
        /sdcard/Android/media/com.whatsapp/WhatsApp/.StickerThumbs/ \
        /sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\ Stickers/ \
        /sdcard/{Aurora/,Telegram/,MIUI/} \
        /sdcard/DCIM/.thumbnails/ \
        /sdcard/Download/apk/Downloads/ \
        /sdcard/Download/Nearby Share/ \
        ~/.local/share/cargo/registry/ \
        ~/downloads/ \
        /sdcard/TachiyomiSY/downloads/*/*/*_tmp/

    for dir in $__dirs
        [ -d "$dir" ] && set -fa dirs "$dir"
    end

    if count $dirs &>/dev/null
        dust -Dd0 -- $dirs 2>/dev/null
        [ "$(read -P 'delete these directories? [y/N] ')" = y ]
        and command rm -fr -- $dirs &>/dev/null
        echo
    end

    count ~/.*_history &>/dev/null &&
        command rm -i -- ~/.*_history

    command -vq pacman && yes | pacman -Scc
    command -vq pip && pip cache purge
    command -vq npm && npm cache clean --force
    command -vq newsboat && newsboat -X

    echo
    echo (count (ls -1NA ~)) files in HOME
    echo (count (ls -1NA $temp)) files in temp
    echo (count (pacman -Qe)) packages installed
    command df -ht fuse | awk '/fuse/{print $3"/"$2,$5" occupied, "$4" free"}'
    echo
    dust -Dd0 -n6 --skip-total $XDG_PROJECTS_DIR/* 2>/dev/null
end
