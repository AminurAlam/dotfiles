function clean
    set -f hist_dirs (fd -Hd1 '^\..*_history$' ~)
    set -f big_dirs \
        /sdcard/Android/data/*youtube/ \
        /sdcard/Android/data/org.schabi.newpipe/ \
        /sdcard/Android/data/org.*messenger/ \
        /sdcard/Android/data/com.spotify.* \
        /sdcard/DCIM/.thumbnails/ \
        /sdcard/Aurora/ \
        /sdcard/Telegram/

    pacman -Scc --noconfirm
    echo

    for dir in $big_dirs
        [ -d $dir ] && set -fa dirs $dir
    end

    if count $dirs &>/dev/null
        command du -hs $dirs
        printf "delete these directories? [y/N] "
        command rm -frI -- $dirs &>/dev/null
        echo
    end

    count $hist_dirs &>/dev/null &&
        command rm -i $hist_dirs &&
    echo

    command -sq rip &&
        yes | rip --decompose &>/dev/null &&
    echo

    command -sq pip &&
        pip cache purge &&
    echo

    echo (count (command exa -al ~)) files in HOME
end
