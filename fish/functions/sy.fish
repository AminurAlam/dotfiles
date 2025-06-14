function sy
    # TODO: use function {...} | exclude-from -
    # update ssh address

    [ (uname -o) = Android ] && return 1
    set ip (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1)
    [ -n "$ip" ] && sed -r -i "s/192\.168\.[0-9]+\.[0-9]+\$/$ip/" ~/.ssh/config

    printf "\033[36m === PICTURES ===\033[0m\n"
    rsync -Pha ~/Pictures/ phone:/sdcard/Pictures/ \
        --exclude 'redmi vid' \
        --exclude 'redmi vid2' \
        --exclude 'WhatsApp Images' \
        --exclude Camera \
        --exclude ocr \
        --exclude TachiyomiSY

    rsync -Pha phone:/sdcard/Pictures/ ~/Pictures/ \
        --exclude .thumbnails \
        --exclude .nomedia

    rsync -Pha phone:/sdcard/DCIM/Camera ~/Pictures/ --delete
    rsync -Pha 'phone:/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images' ~/Pictures/ --delete

    printf "\033[36m === DOCUMENTS ===\033[0m\n"
    rsync -Pha phone:/sdcard/Documents/ ~/Documents/
    rsync -Pha ~/Documents/ phone:/sdcard/Documents/
    pushd "$XDG_PROJECTS_DIR/notes/" && begin
        git pull
        popd
    end

    printf "\033[36m === TORRENTS ===\033[0m\n"
    rsync -Pha ~/Downloads/main/torrents/ phone:/sdcard/main/torrents/
    rsync -Pha phone:/sdcard/main/torrents/ ~/Downloads/main/torrents/

    printf "\033[36m === KEEPASS DB ===\033[0m\n"
    rsync -Pha ~/Downloads/main/arch.kdbx phone:/sdcard/main/arch.kdbx
    rsync -Pha phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx

    printf "\033[36m === MISC ===\033[0m\n"
    # rsync -Pha ~/Downloads/main/ROMS/ phone:/sdcard/Download/main/ROMS/ --delete --exclude Switch
    rsync -Pha ~/.local/share/newsboat/cache.db phone:~/.local/share/newsboat/cache.db
    rsync -Pha phone:/sdcard/main/backup/ ~/Downloads/main/backup/
    rsync -Pha phone:/sdcard/Music/ ~/Music/ --delete --exclude .thumbnails
    rsync -Pha phone:/sdcard/TachiyomiSY/local/#lewd/ ~/Downloads/manga/#lewd/ --delete \
        --exclude @Alp \
        --exclude @Arakure \
        --exclude '@Hinahara Emi' \
        --exclude '@Ouchi Kaeru' \
        --exclude '@Wantan Meo' \
        --exclude @Yuruyakatou \
        --exclude .nomedia
    rsync -Pha phone:/sdcard/TachiyomiSY/local/@{Alp,Arakure,Hinahara Emi,Ouchi Kaeru,Wantan Meo,Yuruyakatou} ~/Downloads/manga/#lewd/ --delete --exclude .nomedia

    # else if [ (uname -o) = Android ]
    #     # FIX: rsync always overwrites
    #     set sdcard (df | awk '/\/storage\/[A-Z0-9]{4}-[A-Z0-9]{4}$/ {print $6}')
    #     echo $sdcard
    # end
end
