function clean
    set -f hist_dirs (fd -tfile -Hd1 '^\..*_history$' ~)
    set -f all_dirs \
        /sdcard/Android/data/{*youtube/,org.schabi.newpipe/,org.*messenger/} \
        /sdcard/Android/data/{com.spotify.*/,com.aspiro.tidal/} \
        /sdcard/Android/data/{xiaomi,miui}*/ \
        /sdcard/Android/data/ru.*/files/LuckyPatcher/Modified/ \
        /sdcard/Android/data/com.xodo.pdf.reader/ \
        /sdcard/{Aurora/,Telegram/,MIUI/} \
        /sdcard/DCIM/.thumbnails/ \
        ~/.local/share/cargo/registry/

    for dir in $all_dirs
        [ -d "$dir" ] && set -fa dirs $dir
    end

    # get dirs from vendetta manager cache
    if [ -d "/sdcard/Android/data/dev.beefers.vendetta.manager/cache/" ]
        for dir in (fd -tdirectory -d1 '^\d+$' /sdcard/Android/data/dev.beefers.vendetta.manager/cache/ | sort | head -n -1)
            [ -d "$dir" ] && set -fa dirs $dir
        end

        set -f latest (fd -tdirectory -d1 '^\d+$' /sdcard/Android/data/dev.beefers.vendetta.manager/cache/ | sort | tail -n 1)
        [ -d "$latest/signed/" ] && set -fa dirs "$latest"signed/
        [ -d "$latest/patched/" ] && set -fa dirs "$latest"patched/

        # set eee (fd -tdirectory -d1 '^\d+$' /sdcard/Android/data/dev.beefers.vendetta.manager/cache/ | sort | head -n -1)
        # set -fa dirs $ee[1..-2]
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
