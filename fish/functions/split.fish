function split
    command -sq sox         || begin echo "sox is not installed";       return 1; end
    [ -d "$argv" ]          || begin echo "'$argv' is not a directory"; return 1; end
    fd -q '.*\.cue' "$argv" || begin echo "no cue files in '$argv'";    return 1; end
end
