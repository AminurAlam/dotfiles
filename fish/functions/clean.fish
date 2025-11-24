function clean -d "cleanup to free storage"
    set dirs (path filter -d -- \
        /sdcard/Android/media/com.whatsapp/WhatsApp/{.StickerThumbs,Media/WhatsApp Stickers}/ \
        /sdcard/TachiyomiSY/downloads/*/*/*_tmp/ \
        ~/.cache/ \
        /sdcard/Download/SongSync \
        ~/.gradle/caches/)

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

    [ -d ~/downloads -a (uname -o) = Android ] && fd -tfile -epng 'Screenshot_.*_Samsung capture.png' ~/downloads/ -x rm

    if command -vq sudo
        command -vq pacman && yes | sudo pacman -Scc
    else
        command -vq pacman && yes | pacman -Scc
    end
    echo
    command -vq trash-empty && trash-empty
    command -vq yay && begin
        yay -Sc --noconfirm
        [ (count (pacman -Qdtq)) -gt 20 ] && yay -Yc
    end

    command -vq pip && pip cache purge
    command -vq npm && npm cache clean --force
    command -vq ccache && ccache --clear
    command -vq journalctl && sudo journalctl --vacuum-time 7d

    echo
    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'
    echo
    dust -PDd1 -n6 --skip-total $HOME/repos/ 2>/dev/null
end
