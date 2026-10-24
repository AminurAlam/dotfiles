function clean -d "cleanup storage space"
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'

    # remove deleted directories from zoxide
    zoxide remove (path filter -vd (zoxide query -la))

    string pad -C -c= -w$COLUMNS " TEMP FILES "
    set files \
        (fd -H -tf -d1 '_history$' "$HOME/") \
        (fd -H -tf -d3 'log$'     "$XDG_STATE_HOME/" "$XDG_CACHE_HOME/") \
        (fd -H -tf -d1 -epng .    "$HOME/downloads/" 2>/dev/null) \
        (path filter -d -- \
            /sdcard/Android/media/com.whatsapp/WhatsApp/{.StickerThumbs,Media/WhatsApp Stickers}/ \
            /sdcard/Tachi/downloads/*/*/*_tmp/ ~/.cache/ /sdcard/Download/SongSync ~/.gradle/caches/)

    if count $files &>/dev/null
        command dust -d1 $files
        command rm -frI -- $files
    end

    string pad -C -c= -w$COLUMNS " PKG FILES "
    # bug: https://gitlab.archlinux.org/pacman/pacman/-/work_items/297
    # fix: https://gitlab.archlinux.org/pacman/pacman/-/merge_requests/348
    count /var/cache/pacman/pkg/download-* &>/dev/null
    and sudo rm -fr /var/cache/pacman/pkg/download-*

    command -vq paccache
    and paccache -r -k0 -v
    or yes | pacman -Scc

    command -vq yay && begin
        yay -Sc --noconfirm
        [ (count (pacman -Qdtq)) -gt 5 ] && yay -Yc
    end

    echo

    string pad -C -c= -w$COLUMNS " TRASH "
    command -vq trash-list
    and trash-list \
        | sed -E "s/^.{20}//; s#$HOME/##; s#/storage/emulated/0/##" \
        | kt / 1 2 3 \
        | sort \
        | uniq -c \
        | sort -n
    command -vq trash-empty && trash-empty

    string pad -C -c= -w$COLUMNS " MISC "
    command -vq pip && pip cache purge
    command -vq npm && npm cache clean --force
    command -vq ccache && ccache --clear
    command -vq journalctl && sudo journalctl --vacuum-time 7d
    command -vq newsraft && newsraft -e purge-abandoned
    # command -vq cargo && fd -H -tf -d1 -F 'Cargo.toml' $HOME/repos/* -x cargo clean --manifest-path

    echo
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'
end
