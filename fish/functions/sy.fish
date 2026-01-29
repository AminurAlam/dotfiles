function sy -d "sync files between phone and pc"
    set -q TERMUX_VERSION && return 1

    set comm --dry-run -ha --out-format "%o %n" --exclude={.thumbnails,.nomedia,.archive}
    set artists Alp Arakure Herio 'Hinahara Emi' Jury 'Morino Bambi' Nagayori 'Nikubou Maranoshin' 'Ouchi Kaeru' Sajipen 'Wantan Meo' Yuruyakatou

    for state in dry wet
        if [ $state = dry ] && [ "$argv[1]" = -y ]
            set -e comm[1]
            continue
        else if [ $state = wet ] && [ "$argv[1]" != -y ]
            [ "$(read -P "make these changes? [y/N] ")" = y ] || continue
            set -e comm[1]
        end

        printf "=== PICTURES ===\n"
        rsync $comm $XDG_PICTURES_DIR/ brick:/sdcard/Pictures/ --exclude={Camera,Komikku,WhatsApp Images} | rg -v '/$'
        rsync $comm brick:/sdcard/Pictures/ $XDG_PICTURES_DIR/ | rg -v '/$'
        rsync $comm brick:/sdcard/{DCIM/Camera,Pictures/Komikku,Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images} $XDG_PICTURES_DIR/ --delete | rg -v '/$'

        printf "=== DOCUMENTS ===\n"
        rsync $comm brick:/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp\ Documents/ $XDG_DOCUMENTS_DIR/wa/ --delete | rg -v '/$'
        rsync $comm brick:/sdcard/Documents/ $XDG_DOCUMENTS_DIR/ | rg -v '/$'
        rsync $comm $XDG_DOCUMENTS_DIR/ brick:/sdcard/Documents/ --exclude wa | rg -v '/$'

        printf "=== MUSIC ===\n"
        # rsync $comm brick:/sdcard/Music/ $XDG_MUSIC_DIR/ --delete | rg -v '/$'

        printf "=== MANGA ===\n"
        # rsync $comm brick:/sdcard/Tachi/local/\#lewd/ $XDG_DOWNLOAD_DIR/manga/\#lewd/ --exclude=@$artists --delete | rg -v '/$'
        # rsync $comm brick:/sdcard/Tachi/local/@$artists $XDG_DOWNLOAD_DIR/manga/\#lewd/ --delete | rg -v '/$'

        printf "=== MISC ===\n"
        rsync $comm $XDG_DOWNLOAD_DIR/main/arch.kdbx brick:/sdcard/main/arch.kdbx
        rsync $comm brick:/sdcard/main/android.kdbx $XDG_DOWNLOAD_DIR/main/android.kdbx
        [ -e $XDG_DATA_HOME/newsraft/newsraft.sqlite3-journal ]
        or rsync $comm $XDG_DATA_HOME/newsraft/newsraft.sqlite3 brick:~/.local/share/newsraft/newsraft.sqlite3
        rsync $comm brick:/sdcard/main/backup/ $XDG_DOWNLOAD_DIR/main/backup/
    end
end
