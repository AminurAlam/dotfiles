function split
    command -sq sox        || begin echo "sox is not installed";       return 1; end
    [ -d "$argv" ]         || begin echo "'$argv' is not a directory"; return 1; end
    fd -qd1 'cue$' "$argv" || begin echo "no cue files in '$argv'";    return 1; end

    set cuefile (fd -d1 'cue$' "$argv")
    echo $cuefile
    set file (awk '/^FILE/ { print $0 }' "$cuefile")
    [ (count $file) -gt 1 ] && begin echo "more than one track to split '$argv'"; return 1; end
    printf "$file" | rg -o '".*"'
end
