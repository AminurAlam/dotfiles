function sy
    # update ssh address
    set ip (route -n | awk '/^[0.]+/{print $2}' | uniq)
    [ -n "$ip" ] && sed -r -i "s/192\.168\.[0-9]+\.[0-9]+\$/$ip/" ~/.ssh/config

    printf "\033[36m === PICTURES ===\033[0m\n"
    rsync --port 8022 -aP --exclude ocr --exclude Camera ~/Pictures/ phone:/sdcard/Pictures/
    rsync --port 8022 -aP --exclude .thumbnails phone:/sdcard/Pictures/ ~/Pictures/
    rsync --port 8022 -aP phone:/sdcard/DCIM/Camera ~/Pictures/ --delete

    printf "\033[36m === DOCUMENTS ===\033[0m\n"
    rsync --port 8022 -aP --exclude notes ~/Documents/ phone:/sdcard/Documents/
    rsync --port 8022 -aP --exclude notes phone:/sdcard/Documents/ ~/Documents/

    printf "\033[36m === TORRENTS ===\033[0m\n"
    rsync --port 8022 -aP ~/Downloads/torrents/ phone:/sdcard/main/torrents/
    rsync --port 8022 -aP phone:/sdcard/main/torrents/ ~/Downloads/torrents/

    printf "\033[36m === KEEPASS DB ===\033[0m\n"
    rsync --port 8022 -aP ~/Downloads/main/arch.kdbx phone:/sdcard/main/arch.kdbx
    rsync --port 8022 -aP phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx

    printf "\033[36m === MISC ===\033[0m\n"
    rsync --port 8022 -aP --exclude Switch ~/Downloads/ROMS/ phone:/sdcard/Download/ROMS/ --delete
    rsync --port 8022 -aP --exclude .thumbnails phone:/sdcard/Music/ ~/Music/ --delete
    rsync --port 8022 -aP phone:/sdcard/TachiyomiSY/local/\#lewd/ ~/Downloads/manga/#lewd/ --delete
end
