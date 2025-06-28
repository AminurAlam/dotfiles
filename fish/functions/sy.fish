function sy
    # TODO: use function {...} | exclude-from -

    [ (uname -o) = Android ] && return 1

    set ip (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1)
    [ -n "$ip" ] && sed -r -i "s/192\.168\.[0-9]+\.[0-9]+\$/$ip/" ~/.ssh/config || return 192

    set comm -ha --out-format "%o %n" --exclude={.thumbnails,.nomedia}

    begin
        # === PICTURES ===
        rsync $comm ~/Pictures/ phone:/sdcard/Pictures/ --exclude={Camera,TachiyomiSY,WhatsApp Images}
        rsync $comm phone:/sdcard/Pictures/ ~/Pictures/
        rsync $comm phone:/sdcard/{DCIM/Camera,Pictures/TachiyomiSY,Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images} ~/Pictures/ --delete

        # === DOCUMENTS ===
        rsync $comm phone:/sdcard/Documents/ ~/Documents/
        rsync $comm ~/Documents/ phone:/sdcard/Documents/

        # === TORRENTS ===
        rsync $comm ~/Downloads/main/torrents/ phone:/sdcard/main/torrents/
        rsync $comm phone:/sdcard/main/torrents/ ~/Downloads/main/torrents/

        # === KEEPASS DB ===
        rsync $comm ~/Downloads/main/arch.kdbx phone:/sdcard/main/arch.kdbx
        rsync $comm phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx

        # === MISC ===
        # rsync ~/Downloads/main/ROMS/ phone:/sdcard/Download/main/ROMS/ --delete --exclude Switch
        rsync $comm ~/.local/share/newsboat/cache.db phone:~/.local/share/newsboat/cache.db
        rsync $comm phone:/sdcard/main/backup/ ~/Downloads/main/backup/
        rsync $comm phone:/sdcard/Music/ ~/Music/ --delete
        rsync $comm phone:/sdcard/TachiyomiSY/local/\#lewd/ ~/Downloads/manga/\#lewd/ --exclude=@{Alp,Arakure,Hinahara Emi,Ouchi Kaeru,Wantan Meo,Yuruyakatou}
        rsync $comm phone:/sdcard/TachiyomiSY/local/@{Alp,Arakure,Hinahara Emi,Ouchi Kaeru,Wantan Meo,Yuruyakatou} ~/Downloads/manga/\#lewd/ --delete
    end | rg -v '/$' | sed -r 's/^send /-> /; s/^recv /<- /; s/^del\. /-- /'
end
