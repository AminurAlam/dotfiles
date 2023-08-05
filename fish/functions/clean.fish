function clean
    set -f hist_dirs (fd -Hd1 '^\..*_history$' ~)
    set -f all_dirs \
        /sdcard/Android/data/{*youtube/,org.schabi.newpipe/,org.*messenger/} \
        /sdcard/Android/data/{com.spotify.*/,com.aspiro.tidal/} \
        /sdcard/{Aurora/,Telegram/} \
        /sdcard/DCIM/.thumbnails/ \
        ~/.local/share/cargo/registry/

    for dir in $all_dirs
        [ -d "$dir" ] && set -fa dirs $dir
    end

    yes | pacman -Scc
    echo

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

    echo (count (ls -1NA ~)) files in HOME
    echo (count (pacman -Qe)) packages installed
end
