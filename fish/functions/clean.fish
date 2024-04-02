function clean
    set -f hist_dirs (fd -tfile -Hd1 '^\..*_history$' ~)
    set -f all_dirs \
        /sdcard/{Aurora/,Telegram/,MIUI/} \
        /sdcard/DCIM/.thumbnails/ \
        /sdcard/Download/apk/Downloads \
        /sdcard/Download/Nearby Share/ \
        ~/.local/share/cargo/registry/ \
        (fd -tdirectory '_tmp$' /sdcard/TachiyomiSY/)
    set -f perm_dir \
        /sdcard/Android/data/{*youtube*/,org.schabi.newpipe/,org.*messenger/} \
        /sdcard/Android/data/{com.spotify.*/,com.aspiro.tidal/} \
        /sdcard/Android/data/{xiaomi,miui}*/ \
        /sdcard/Android/data/ru.*/files/LuckyPatcher/Modified/ \
        /sdcard/Android/data/com.xodo.pdf.reader/

    for dir in $all_dirs
        if [ -d "$dir" ]
            [ -r "$dir" ] && set -fa dirs $dir || set -fa perm_dir $dir
        end
    end

    yes | pacman -Scc
    echo

    if count $dirs &>/dev/null
        command du -hs $dirs
        [ "$(read -P 'delete these directories? [y/N] ')" = y ] && command rm -fr -- $dirs &>/dev/null
        echo
    end

    if count $perm_dir >/dev/null && command -vq rish
        rish -c "du -hs $perm_dir"
        [ "$(read -P 'delete these directories? [y/N] ')" = y ] && rish -c "rm -fr -- $perm_dir" &>/dev/null
        echo
    end

    count $hist_dirs &>/dev/null &&
        command rm -i $hist_dirs &&
    echo

    command -vq rip &&
        yes | rip --decompose &>/dev/null &&
    echo

    command -vq pip &&
        pip cache purge &&
    echo

    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
end
