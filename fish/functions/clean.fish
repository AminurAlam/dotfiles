function clean
    set -f awkscript '/\/dev\/fuse/ {
printf("%8s (\033[%dm%3s\033[0m) %6s/%-6s %5s free\n",
    ($6 ~ /emulated/) ? "Internal" : "SD Card",
    ($5 > 90) ? ($5 > 95 ? 31 : 33) : 32, $5,
    $3, $2, $4)
}'
    set -f hist_dirs (fd -tfile -Hd1 '^\..*_history$' ~)
    set -f __dirs \
        /sdcard/Android/media/com.whatsapp/WhatsApp/.StickerThumbs/ \
        /sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\ Stickers/ \
        /sdcard/{Aurora/,Telegram/,MIUI/} \
        /sdcard/DCIM/.thumbnails/ \
        /sdcard/Download/apk/Downloads/ \
        /sdcard/Download/Nearby Share/ \
        ~/.local/share/cargo/registry/ \
        ~/downloads/ \
        (fd -tdirectory '_tmp$' /sdcard/TachiyomiSY/)

    for dir in $__dirs
        [ -d "$dir" ] && set -fa dirs $dir
    end

    if count $dirs &>/dev/null
        command du -hs -- $dirs
        [ "$(read -P 'delete these directories? [y/N] ')" = y ]
        and command rm -fr -- $dirs &>/dev/null
        echo
    end

    count $hist_dirs &>/dev/null &&
        command rm -i -- $hist_dirs &&
    echo

    yes | pacman -Scc
    echo

    command -vq pip &&
        pip cache purge &&
    echo

    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
    echo
    command df -ht fuse | awk "$awkscript"
    echo
    command -vq dust && dust -Dd0 -n6 --skip-total --no-progress $XDG_PROJECTS_DIR/* 2>/dev/null
end
