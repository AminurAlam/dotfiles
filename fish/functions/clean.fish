function clean -d "cleanup storage space"
    # delete some directories
    set dirs (path filter -d -- \
        /sdcard/Android/media/com.whatsapp/WhatsApp/{.StickerThumbs,Media/WhatsApp Stickers}/ \
        /sdcard/Tachi/downloads/*/*/*_tmp/ \
        ~/.cache/ \
        /sdcard/Download/SongSync \
        ~/.gradle/caches/)

    if count $dirs &>/dev/null
        dust -PDd0 -- $dirs 2>/dev/null
        [ "$(read -P 'delete these directories? [y/N] ')" = y ]
        and command rm -fr -- $dirs &>/dev/null
        echo
    end

    # delete some files
    set files (fd -H -tf -d1 '_history$' ~) (fd -H -tf -d2 'log$' "$XDG_STATE_HOME")

    if count $files &>/dev/null
        command du -h $files
        command rm -fr -- $files
    end

    # ocr leftovers
    [ -d ~/downloads -a (uname -o) = Android ] && fd -tfile -epng 'Screenshot_.*_Samsung capture.png' ~/downloads/ -x rm

    # pacman/yay
    if command -vq sudo
        count /var/cache/pacman/pkg/download-* &>/dev/null && sudo rm -frI /var/cache/pacman/pkg/download-*
        command -vq pacman && yes | sudo pacman -Scc
    else
        command -vq pacman && yes | pacman -Scc
    end

    echo

    # trash
    for i in (trash-list)
        echo $i \
            | rg --replace '' '^\d{4}-\d\d-\d\d \d\d:\d\d:\d\d ' \
            | sed "s#$HOME/##" \
            | sed 's#/storage/emulated/0/##' \
            | string split -f 1,2,3 / | string join /
    end | sort | uniq -c | sort -n
    command -vq trash-empty && trash-empty
    command -vq yay && begin
        yay -Sc --noconfirm
        [ (count (pacman -Qdtq)) -gt 10 ] && yay -Yc
    end

    # remove deleted directories from zoxide
    for d in (zoxide query -la)
        [ -e "$d" ] && continue
        zoxide remove $d
    end

    # misc
    command -vq pip && pip cache purge
    command -vq npm && npm cache clean --force
    command -vq ccache && ccache --clear
    command -vq journalctl && sudo journalctl --vacuum-time 7d

    echo
    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
    echo
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'
    echo
    dust -PDd1 -n6 --skip-total $HOME/repos/ 2>/dev/null
end
