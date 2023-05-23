function clean
    set -f dirs \
        /sdcard/Android/data/*youtube/ \
        /sdcard/Android/data/org.schabi.newpipe/ \
        /sdcard/Android/data/org.*messenger/ \
        /sdcard/Android/data/com.spotify.* \
        "/sdcard/DCIM/.thumbnails/" \
        "/sdcard/Aurora/" \
        "/sdcard/Telegram/"

    yes | pacman -Scc 2> /dev/null
    echo

    for dir in $dirs
        echo "  $dir"
    end

    command rm -fr $dirs 2> /dev/null
    echo

    command -sq rip && yes | rip --decompose &> /dev/null && echo
    command -sq pip && pip cache purge && echo

    echo (count (command exa -al ~)) files in HOME
end
