function clean
    set -f dirs \
        /sdcard/Android/data/*youtube/ \
        /sdcard/Android/data/org.schabi.newpipe/ \
        /sdcard/Android/data/org.*messenger/ \
        /sdcard/Android/data/com.spotify.* \
        "/sdcard/DCIM/.thumbnails/" \
        "/sdcard/Aurora/" \
        "/sdcard/Telegram/"

    yes | pkg autoclean

    for dir in $dirs
        echo "  $dir"
    end
    command rm -rf $dirs 2> /dev/null
    command -sq rip && yes | rip --decompose &> /dev/null
    command -sq pip && pip cache purge
    echo (count (command exa -al ~)) files in HOME
end
