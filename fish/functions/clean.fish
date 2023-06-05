function clean
    set -f dirs \
        /sdcard/Android/data/*youtube/ \
        /sdcard/Android/data/org.schabi.newpipe/ \
        /sdcard/Android/data/org.*messenger/ \
        /sdcard/Android/data/com.spotify.* \
        /sdcard/DCIM/.thumbnails/ \
        /sdcard/Aurora/ \
        /sdcard/Telegram/

    yes | pacman -Scc
    echo

    for dir in $dirs
        [ -d $dir ] && command du -hs $dir
    end

    printf "delete these directories? [y/N] "
    command rm -frI $dirs &>/dev/null
    echo

    command rm -i ~/.*_history
    echo

    command -sq rip && yes | rip --decompose &>/dev/null && echo
    command -sq pip && pip cache purge && echo

    echo (count (command exa -al ~)) files in HOME
end
