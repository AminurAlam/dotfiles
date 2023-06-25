function gcp
    set -l url "$argv[1]"
    set -l path "$argv[2]"
    [ -n "$depth" ] &&
        set -l depth "--depth" "$depth" ||
        set -l depth "--depth" "1"
    # [ -n "$branch" ] &&
    #     set -l branch "--branch" "$branch" ||
    #     set -l branch ""

    cd "$XDG_PROJECTS_DIR"
    git clone $depth -- "$url" "$path"
    # TODO: cd into most recent dir
    cd "$XDG_PROJECTS_DIR/$path"

end
