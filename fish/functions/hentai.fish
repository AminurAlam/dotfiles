function hentai
    : "USAGE:
    hentai
    hentai [dir [dir...]]
    "
    set mangadir /sdcard/TachiyomiSY
    # set targetdir "$mangadir/local/#lewd"
    set targetdir "$mangadir/downloads/HentaiNexus (EN)/#processed"

    set -q TERMUX_VERSION || return 1
    [ -d "$mangadir" ] || return 1

    printf "working on HentaiNexus...\n"
    cd "$mangadir/downloads/HentaiNexus (EN)/" 2>/dev/null
    and for i in @*
        # TODO: match for known artists
        printf " - $i\n"
        mv -i --no-clobber $i/Chapter.cbz $targetdir/$i.cbz
        rmdir $i &>/dev/null
    end

    printf "working on Doujin.io...\n"
    cd "$mangadir/downloads/Doujin.io - J18 (EN)" 2>/dev/null
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
        mv -i --no-clobber $i.cbz $targetdir/
    end

    [ -z "$argv[1]" ] && return 0
    printf "working on args...\n"
    cd "$targetdir"
    set name (fd -tf -d1 -ecbz . | fzf)
    cd "$mangadir/downloads/HentaiNexus (EN)/" || return 3

    # TODO: get artist name from ComicInfo.xml
    # TODO: ask author name
    if [ -z "$name" ]
        # get biggest common substring
        for n in (seq (string length $argv[1]) -1 1)
            set sub (string trim (string sub -l $n $argv[1]))
            string match -q "$sub*" $argv[2]
            and break
        end

        if [ "$(string length -- "$sub")" -le 2 ]
            set name (string join + $argv)
        else
            set name "$sub 1-$(count $argv)"
        end

        set name (string replace -a -- / '' "$name")

        mkdir -p $name

    else
        set name (path change-extension '' "$name")
        # printf "adding to `%s` ...\n" $name

        # unzip $name
        unzip -qd "$name" "$targetdir/$name.cbz"

        # get count
        set count 1
        while [ -e "$name/$count" ]
            set count (math $count + 1)
        end
        set count (math $count - 1)
        set oldcount $count
    end

    for i in $argv/Chapter.cbz
        [ -e "$i" ] || continue
        set count (math $count + 1)
        mkdir -p $name/$count
        unzip -qd $name/$count $i
    end

    # TODO: update series name   ????
    # set oldname $name
    # set name (string replace -- " 1-$oldcount" " 1-$count" "$name")
    # mv -i "$oldname" "$name"

    printf ' - '
    dir2cbz $name && rm -fr $name/
    printf "   - %s\n" $argv
    mv -i $name.cbz $targetdir/
end
