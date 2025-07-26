function hentai
    set -q TERMUX_VERSION || return 1

    printf "working on HentaiNexus...\n"
    cd "/storage/emulated/0/TachiyomiSY/downloads/HentaiNexus (EN)/"
    and for i in @*
        printf " - $i\n"
        mv -i --no-clobber $i/Chapter.cbz /sdcard/TachiyomiSY/local/\#lewd/$i.cbz
        rmdir $i &>/dev/null
    end

    printf "working on Doujin.io...\n"
    cd "/sdcard/TachiyomiSY/downloads/Doujin.io - J18 (EN)"
    and for i in @*
        printf " - $i\n"
        pushd $i
        # NOTE: may need to be sorted manually
        for ch in *.cbz
            printf "   - $ch\n"
            unzip -qd (path change-extension '' $ch) $ch
            rm $ch
        end
        popd
        dir2cbz $i && rm -fr $i
        mv -i --no-clobber $i.cbz /sdcard/TachiyomiSY/local/\#lewd/
    end

    # TODO: append new chapters
    # TODO: ask author name
    set args (count $argv)
    [ $args -lt 2 ] && return 2
    cd "/storage/emulated/0/TachiyomiSY/downloads/HentaiNexus (EN)/" || return 3

    for n in (seq (string length $argv[1]) -1 1)
        set sub (string trim (string sub -l $n $argv[1]))
        string match -q "$sub*" $argv[2]
        and break
    end
    set name "$sub 1-$args"

    mkdir -p $name

    for i in $argv/Chapter.cbz
        set count (math $count + 1)
        mkdir -p $name/$count
        unzip -qd $name/$count $i
    end

    dir2cbz $name && rm -fr $name/
    mv -i --no-clobber $name.cbz /sdcard/TachiyomiSY/local/\#lewd/
end
