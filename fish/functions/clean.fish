function clean -d "cleanup to free storage"
    set sudo (command -v sudo || command -v doas)
    set -f __dirs \
        /sdcard/Android/media/com.whatsapp/WhatsApp/.StickerThumbs/ \
        /sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\ Stickers/ \
        /sdcard/{Aurora/,Telegram/,MIUI/} \
        /sdcard/DCIM/.thumbnails/ \
        /sdcard/Download/Nearby\ Share/ \
        /sdcard/TachiyomiSY/downloads/*/*/*_tmp/ \
        ~/.local/share/cargo/registry/ \
        ~/.gradle/caches/

    for dir in $__dirs
        [ -d "$dir" ] && set -fa dirs "$dir"
    end

    if count $dirs &>/dev/null
        dust -PDd0 -- $dirs 2>/dev/null
        [ "$(read -P 'delete these directories? [y/N] ')" = y ]
        and command rm -fr -- $dirs &>/dev/null
        echo
    end

    set files \
        (fd -H -tf -d1 '_history$' ~) \
        (fd -H -tf -d2 'log$' "$XDG_STATE_HOME")

    if count $files &>/dev/null
        command -vq eza
        and l $files
        or command du -h $files
        command rm -fr -- $files
    end

    [ -d ~/downloads ] && fd -tfile -epng . ~/downloads/ -x rm


    command -vq pacman && yes | $sudo pacman -Scc
    command -vq yay && yay -Yc
    command -vq pip && pip cache purge
    command -vq npm && npm cache clean --force
    command -vq newsboat && not ps a | rg -q newsboat && newsboat -X
    command -vq ccache && ccache --clear

    echo
    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
    command df -h | awk '/fuse/{print $3"/"$2,$5,$4}'
    echo
    dust -PDd0 -n6 --skip-total $XDG_PROJECTS_DIR/* 2>/dev/null
end
