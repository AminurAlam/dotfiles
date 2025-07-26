function sy -d "sync files between phone and pc"
    set -q TERMUX_VERSION && return 1

    set ip (route -n | awk '/^[0.]+/{print $2}' | rg -v '127\.0\.0\.1' | uniq | head -n1)
    [ -n "$ip" ] && sed -r -i "s/192\.168\.[0-9]+\.[0-9]+\$/$ip/" ~/.ssh/config || return 192

    set send true
    set recv true
    set comm -ha --out-format "%o %n" --exclude={.thumbnails,.nomedia}

    switch "$argv[1]"
        case ip
            return 0
        case send
            set recv false
        case recv
            set send false
        case dry
            set -a comm --dry-run
        case ""
            :
        case '*'
            printf "usage `sy [ip|send|recv|dry]`\n"
            return 1
    end

    begin
        printf "=== PICTURES ===\n"
        $send && rsync $comm ~/Pictures/ phone:/sdcard/Pictures/ --exclude={Camera,Komikku,WhatsApp Images}
        $recv && rsync $comm phone:/sdcard/Pictures/ ~/Pictures/
        $recv && rsync $comm phone:/sdcard/{DCIM/Camera,Pictures/Komikku,Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images} ~/Pictures/ --delete

        printf "=== DOCUMENTS ===\n"
        $recv && rsync $comm phone:/sdcard/Documents/ ~/Documents/
        $send && rsync $comm ~/Documents/ phone:/sdcard/Documents/

        printf "=== TORRENTS ===\n"
        $send && rsync $comm ~/Downloads/main/torrents/ phone:/sdcard/main/torrents/
        $recv && rsync $comm phone:/sdcard/main/torrents/ ~/Downloads/main/torrents/

        printf "=== KEEPASS DB ===\n"
        $send && rsync $comm ~/Downloads/main/arch.kdbx phone:/sdcard/main/arch.kdbx
        $recv && rsync $comm phone:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx

        printf "=== MISC ===\n"
        # $send && rsync ~/Downloads/main/ROMS/ phone:/sdcard/Download/main/ROMS/ --delete --exclude Switch
        $send && rsync $comm ~/.local/share/newsboat/cache.db phone:~/.local/share/newsboat/cache.db
        $recv && rsync $comm phone:/sdcard/main/backup/ ~/Downloads/main/backup/
        # $recv && rsync $comm phone:/sdcard/Music/ ~/Music/ --delete
        $recv && rsync $comm phone:/sdcard/TachiyomiSY/local/\#lewd/ ~/Downloads/manga/\#lewd/ --exclude=@{Alp,Arakure,Hinahara Emi,Ouchi Kaeru,Wantan Meo,Yuruyakatou} --delete
        $recv && rsync $comm phone:/sdcard/TachiyomiSY/local/@{Alp,Arakure,Hinahara Emi,Ouchi Kaeru,Wantan Meo,Yuruyakatou} ~/Downloads/manga/\#lewd/ --delete
    end | rg -v '/$'
end
