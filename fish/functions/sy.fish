function sy
    printf "\033[36m === PICTURES ===\033[0m\n"
    rsync --port 8022 -aP ~/Pictures/ user@phone:/sdcard/Pictures/
    rsync --port 8022 -aP --exclude .thumbnails user@phone:/sdcard/Pictures/ ~/Pictures/

    printf "\033[36m === DOCUMENTS ===\033[0m\n"
    rsync --port 8022 -aP ~/Documents/ user@phone:/sdcard/Documents/
    rsync --port 8022 -aP user@phone:/sdcard/Documents/ ~/Documents/

    printf "\033[36m === TORRENTS ===\033[0m\n"
    rsync --port 8022 -aP ~/Downloads/torrents/ user@phone:/sdcard/main/torrents/
    rsync --port 8022 -aP user@phone:/sdcard/main/torrents/ ~/Downloads/torrents/

    printf "\033[36m === KEEPASS DB ===\033[0m\n"
    rsync --port 8022 -aP ~/Downloads/main/arch.kdbx user@phone:/sdcard/main/arch.kdbx
    rsync --port 8022 -aP user@phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx

    printf "\033[36m === ROMS ===\033[0m\n"
    rsync --port 8022 -aP --exclude 'Guilty Gear Strive' ~/Downloads/ROMS/ user@phone:/sdcard/Download/ROMS/
    rsync --port 8022 -aP user@phone:/sdcard/Download/ROMS/ ~/Downloads/ROMS/
end
