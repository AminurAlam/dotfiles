function sy
    echo "PICTURES"
    rsync --port 8022 -aP --exclude .thumbnails ~/Pictures/ user@phone:/sdcard/Pictures/
    rsync --port 8022 -aP --exclude .thumbnails user@phone:/sdcard/Pictures/ ~/Pictures/

    echo "DOCUMENTS"
    rsync --port 8022 -aP ~/Documents/ user@phone:/sdcard/Documents/
    rsync --port 8022 -aP user@phone:/sdcard/Documents/ ~/Documents/

    echo "TORRENTS"
    # ssh phone -- 'unexe /sdcard/main/torrents/**.torrent'
    rsync --port 8022 -aP ~/Downloads/torrents/ user@phone:/sdcard/main/torrents/
    rsync --port 8022 -aP user@phone:/sdcard/main/torrents/ ~/Downloads/torrents/

    echo "KEEPASS DB"
    rsync --port 8022 -aP ~/Downloads/main/arch.kdbx user@phone:/sdcard/main/arch.kdbx
    rsync --port 8022 -aP user@phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx
end
