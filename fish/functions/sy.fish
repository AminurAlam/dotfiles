function sy -d "sync files between phone and pc"
    set -q TERMUX_VERSION && return 1

    # TODO: verify connected device
    # set ip (route -n | awk '/^[0.]+/{print $2}' | rg -v '127\.0\.0\.1' | uniq | head -n1)
    # [ -n "$ip" ] && sed -r -i "s/192\.168\.[0-9]+\.[0-9]+ #brick\$/$ip #brick/" ~/.ssh/config || return 192

    set comm --dry-run -ha --out-format "%o %n" --exclude={.thumbnails,.nomedia,.archive}
    set artists Alp Arakure Herio 'Hinahara Emi' Jury 'Morino Bambi' Nagayori 'Nikubou Maranoshin' 'Ouchi Kaeru' Sajipen 'Wantan Meo' Yuruyakatou

    for state in dry wet
        if [ $state = dry ] && [ "$argv[1]" = -y ]
            continue
        else if [ $state = wet ] && [ "$argv[1]" != -y ]
            [ "$(read -P "make these changes? [y/N] ")" = y ] || continue
            set -e comm[1]
        end

        printf "=== PICTURES ===\n"
        rsync $comm ~/Pictures/ brick:/sdcard/Pictures/ --exclude={Camera,Komikku,WhatsApp Images} | rg -v '/$'
        rsync $comm brick:/sdcard/Pictures/ ~/Pictures/ | rg -v '/$'
        rsync $comm brick:/sdcard/{DCIM/Camera,Pictures/Komikku,Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images} ~/Pictures/ --delete | rg -v '/$'

        printf "=== DOCUMENTS ===\n"
        rsync $comm brick:/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\ Documents/ ~/Documents/wa_docs/ --delete | rg -v '/$'
        rsync $comm brick:/sdcard/Documents/ ~/Documents/ | rg -v '/$'
        rsync $comm ~/Documents/ brick:/sdcard/Documents/ --exclude wa_docs | rg -v '/$'

        printf "=== MUSIC ===\n"
        rsync $comm brick:/sdcard/Music/ ~/Music/ --delete | rg -v '/$'

        printf "=== MANGA ===\n"
        rsync $comm brick:/sdcard/TachiyomiSY/local/\#lewd/ ~/Downloads/manga/\#lewd/ --exclude=@$artists --delete | rg -v '/$'
        rsync $comm brick:/sdcard/TachiyomiSY/local/@$artists ~/Downloads/manga/\#lewd/ --delete | rg -v '/$'

        printf "=== MISC ===\n"
        rsync $comm ~/Downloads/main/arch.kdbx brick:/sdcard/main/arch.kdbx
        rsync $comm brick:/sdcard/main/android.kdbx ~/Downloads/main/android.kdbx
        [ -e ~/.local/share/newsraft/newsraft.sqlite3-journal ]
        or rsync $comm /home/fisher/.local/share/newsraft/newsraft.sqlite3 brick:~/.local/share/newsraft/newsraft.sqlite3
        rsync $comm brick:/sdcard/main/backup/ ~/Downloads/main/backup/
    end
end
