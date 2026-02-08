function hentai -d "for managing literature"
    set mangadir /sdcard/Tachi

    # TODO: join artists from multiple files
    function getartist # .../file.cbz -> artist?
        unzip -p $argv[1] ComicInfo.xml | rg --only-matching --replace '$1' '<Penciller>(.*)</Penciller>' || termux-clipboard-get
    end

    function gettarget # "@artist - chapter" -> ".../#lewd/@artist - chapter" | ".../@artist/chapter"
        set parts (string split ' - ' $argv[1])
        [ -e "/sdcard/Tachi/local/$parts[1]" -a -n "$parts[2]" ]
        and printf "/sdcard/Tachi/local/%s/%s" $parts[1] $parts[2]
        or printf "/sdcard/Tachi/local/#lewd/%s" $argv[1]
    end

    set -q TERMUX_VERSION || return 1
    [ -d "$mangadir" ] || return 1

    for i in "$mangadir/downloads/HentaiNexus (EN)/"@*
        set base (path basename $i)
        printf " - $base\n"
        zip -qd $i/Chapter_*.cbz ComicInfo.xml
        mv -i --no-clobber $i/Chapter_*.cbz (gettarget $base).cbz
        rmdir $i &>/dev/null
    end

    for i in "$mangadir/downloads/Doujin.io - J18 (EN)/"*
        set base (path basename $i)
        printf " - $base\n"
        # NOTE: may need to be sorted manually
        for ch in $i/*.cbz
            printf "   - %s\n" (path basename $ch | string replace -r -- '_[0-9a-f]{6}\.cbz$' '.cbz')
            set -a artists (getartist $ch)
            unzip -qd (string replace -r -- '_[0-9a-f]{6}\.cbz$' '' $ch) $ch
            rm $ch
        end
        set artist @(printf "%s\n" $artists | sort | uniq | string join +)
        mv -i --no-clobber (dir2cbz $i) (gettarget "$artist - $base").cbz
        or printf "   file with same name already exists!\n"
        rm -rf $i
    end

    [ -z "$argv[1]" ] && return 0
    printf "working on args...\n"
    set name (fd -tf -d1 -ecbz . (fd -td -d1 '^(@|#)' $mangadir/local/) | fzf)

    if [ -n "$name" ] # file exists
        set count (math max (
            zipinfo -1 "$name" \
            | rg --only-matching --replace '$1' '^(\d+)/' \
            | sort \
            | uniq \
            | sort \
            | string join ,
        ) || return 2)
        set target $name
    else # new file
        set name (printf "%s\n" $argv | sed -e '$!{N;s/^\(.*\).*\n\1.*$/\1\n\1/;D;}' | string trim) # get biggest common substring

        [ "$(string length -- "$name")" -le 4 ]
        and set name (string join + $argv | string replace -a -- / '')
        or set name "$name 1-$(count $argv)"

        set artist (getartist (fd -tf -d1 -ecbz -1 . $argv[1]))
        set name "@$artist - $name"

        set nfile (mktemp -t hentai.XXXXXXXX)
        echo -- "$name" >$nfile
        nvim $nfile
        set name (cat $nfile).cbz
        set target (gettarget $name)
    end

    # to stop renaming new files with new count
    test -e "$target"
    set existatus $status

    # create archive
    set hdir (mktemp -dt hentai.XXXXXXXX)
    for chz in $argv/Chapter_*.cbz
        set count (math $count + 1)
        mkdir -p $hdir/$count
        unzip -qd $hdir/$count $chz
        pushd "$hdir"
        zip -0rq "$target" "$count"
        rm -rf "$count"
        popd
    end

    # rename if needed
    if [ "$existatus" = 0 ]
        set nfile (mktemp -t hentai.XXXXXXXX)
        echo -- (string replace -r -- ' 1-\d+.cbz$' " 1-$count.cbz" "$target") >$nfile
        nvim $nfile
        set newname (cat $nfile)
        [ "$target" != "$newname" ]
        and mv -iv "$target" "$newname"
    end

    [ -d "$hdir" ] && rmdir $hdir
    [ -e "$nfile" ] && rm $nfile
end
