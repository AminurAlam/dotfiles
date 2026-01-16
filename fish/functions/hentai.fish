function hentai -d "for managing literature"
    : "USAGE:
    hentai
    hentai [dir [dir...]]
    "
    set mangadir /sdcard/TachiyomiSY
    set targetdir "$mangadir/local/#lewd"
    function getartist
        unzip -p $argv[1]/Chapter*.cbz ComicInfo.xml | rg --only-matching --replace '$1' '<Penciller>(.*)</Penciller>' || termux-clipboard-get
    end

    set -q TERMUX_VERSION || return 1
    [ -d "$mangadir" ] || return 1

    printf "working on HentaiNexus...\n"
    cd "$mangadir/downloads/HentaiNexus (EN)/" 2>/dev/null
    and for i in @*
        # TODO: match for known artists
        printf " - $i\n"
        mv -i --no-clobber $i/Chapter*.cbz $targetdir/$i.cbz
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
    [ -e "$targetdir" ] || mkdir -p "$targetdir"
    cd "$targetdir"
    set name (fd -tf -d1 -ecbz . | fzf)
    cd "$mangadir/downloads/HentaiNexus (EN)/" || return 3

    if [ -n "$name" ]
        set count (math max (
            zipinfo -1 "$targetdir/$name" \
            | rg --only-matching --replace '$1' '^(\d+)/' \
            | sort \
            | uniq \
            | sort \
            | string join ,
        ))
    else # adding to cbz
        set name (printf "%s\n" $argv | sed -e '$!{N;s/^\(.*\).*\n\1.*$/\1\n\1/;D;}' | string trim) # get biggest common substring

        [ "$(string length -- "$name")" -le 4 ]
        and set name (string join + $argv | string replace -a -- / '')
        or set name "$name 1-$(count $argv)"

        set name "@$(getartist $argv[1]) - $name"

        set nfile (mktemp -t hentai.XXXXXXXX)
        echo -- "$name" >$nfile
        nvim $nfile
        set name (cat $nfile).cbz
    end

    set hdir (mktemp -dt hentai.XXXXXXXX)
    for chz in $argv/Chapter*.cbz
        [ -e "$chz" ] || continue
        set count (math $count + 1)
        mkdir -p $hdir/$count
        unzip -qd $hdir/$count $chz
        pushd "$hdir"
        zip -0rq "$targetdir/$name" "$count"
        rm -rf "$count"
        popd
    end

    set newname (string replace -r -- " 1-\d+.cbz" " 1-$count.cbz" "$name")
    [ -n "$newname" -a "$name" != "$newname" ] && mv -iv "$targetdir/$name" "$targetdir/$newname"
    rm -rf "$hdir" "$nfile"
end
