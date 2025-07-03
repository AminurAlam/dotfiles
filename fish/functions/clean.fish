function clean -d "cleanup to free storage"
    set -f __dirs \
        /sdcard/Android/media/com.whatsapp/WhatsApp/{.StickerThumbs,Media/WhatsApp Stickers}/ \
        /sdcard/TachiyomiSY/downloads/*/*/*_tmp/ \
        ~/.cache/ \
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

    [ -d ~/downloads -a (uname -o) = Android ] && fd -tfile -epng . ~/downloads/ -x rm


    if command -vq sudo
        command -vq pacman && yes | sudo pacman -Scc
    else
        command -vq pacman && yes | pacman -Scc
    end
    command -vq yay && yay -Yc
    command -vq pip && pip cache purge
    command -vq npm && npm cache clean --force
    command -vq newsboat && not ps a | rg -q newsboat && newsboat -X
    command -vq ccache && ccache --clear
    command -vq journalctl && sudo journalctl --vacuum-time 7d

    echo
    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'
    echo
    dust -PDd1 -n6 --skip-total $HOME/repos/ 2>/dev/null
end
