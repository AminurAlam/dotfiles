function gcp -a url path branch
    [ -n "$branch" ] && set -l __branch "--branch" "$branch"

    cd "$XDG_PROJECTS_DIR"
    git clone --depth 1 $__branch -- $url $path
    # TODO: cd into most recent dir
    # cd "$XDG_PROJECTS_DIR/$path"
    cd (ls -N1 --sort time | head -n1)

end
