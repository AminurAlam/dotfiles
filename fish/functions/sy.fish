function sy
    # update ssh address
    sed -r -i "s/192\.168\.[0-9]+\.[0-9]+\$/$(route -n | awk '/^[0.]+/{print $2}' | uniq)/" ~/.ssh/config

    printf "\033[36m === PICTURES ===\033[0m\n"
    rsync --port 8022 -aP --exclude ocr ~/Pictures/ user@phone:/sdcard/Pictures/
    rsync --port 8022 -aP --exclude .thumbnails user@phone:/sdcard/Pictures/ ~/Pictures/

    printf "\033[36m === DOCUMENTS ===\033[0m\n"
    rsync --port 8022 -aP --exclude notes ~/Documents/ user@phone:/sdcard/Documents/
    rsync --port 8022 -aP --exclude notes user@phone:/sdcard/Documents/ ~/Documents/

    printf "\033[36m === TORRENTS ===\033[0m\n"
    rsync --port 8022 -aP ~/Downloads/torrents/ user@phone:/sdcard/main/torrents/
    rsync --port 8022 -aP user@phone:/sdcard/main/torrents/ ~/Downloads/torrents/

    printf "\033[36m === KEEPASS DB ===\033[0m\n"
    rsync --port 8022 -aP ~/Downloads/main/arch.kdbx user@phone:/sdcard/main/arch.kdbx
    rsync --port 8022 -aP user@phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx

    printf "\033[36m === ROMS ===\033[0m\n"
    rsync --port 8022 -aP --exclude 'Switch' ~/Downloads/ROMS/ user@phone:/sdcard/Download/ROMS/ --delete
end
