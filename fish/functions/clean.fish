function clean
    set -f dirs \
        /sdcard/Android/data/*youtube/ \
        /sdcard/Android/data/org.schabi.newpipe/ \
        /sdcard/Android/data/org.*messenger/ \
        "/sdcard/Android/data/com.spotify.music/" \
        "/sdcard/DCIM/.thumbnails/" \
        "/sdcard/Aurora/" \
        "/sdcard/Telegram/"

    pkg autoclean

    for dir in $dirs
        echo "  $dir"
    end
    command rm -rf $dirs 2>/dev/null
    command -sq python && pip cache purge
    echo (count (command ls -1Na)) files in HOME
end
