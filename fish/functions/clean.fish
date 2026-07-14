function clean -d "cleanup storage space"
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'

    # remove deleted directories from zoxide
    zoxide remove (path filter -vd (zoxide query -la))

    string pad -C -c= -w$COLUMNS " TEMP FILES "
    set files \
        (fd -H -tf -d1 '_history$' "$HOME/") \
        (fd -H -tf -d3 'log$'     "$XDG_STATE_HOME/") \
        (fd -H -tf -d1 -epng .    "$HOME/downloads/" 2>/dev/null) \
        (path filter -d -- \
            /sdcard/Android/media/com.whatsapp/WhatsApp/{.StickerThumbs,Media/WhatsApp Stickers}/ \
            /sdcard/Tachi/downloads/*/*/*_tmp/ ~/.cache/ /sdcard/Download/SongSync ~/.gradle/caches/)

    if count $files &>/dev/null
        command dust -d1 $files
        command rm -frI -- $files
    end

    string pad -C -c= -w$COLUMNS " PKG FILES "
    if command -vq sudo
        fd -H -td -d1 -q '^download-.*' /var/cache/pacman/pkg/
        and sudo rm -frI (fd -H -td -d1 '^download-.*' /var/cache/pacman/pkg/)

        command -vq pacman && yes | sudo pacman -Scc
    else if set -q TERMUX_VERSION
        yes | pacman -Scc
    end

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
    command -vq journalctl && journalctl --vacuum-time 7d
    command -vq newsraft && newsraft -e purge-abandoned
    # command -vq cargo && fd -H -tf -d1 -F 'Cargo.toml' $HOME/repos/* -x cargo clean --manifest-path

    echo
    command df -h | awk '/fuse|home/{print $3"/"$2,$5,$4}'
end
