function gcp -a url path branch
    [ -n "$branch" ] && set -l __branch "--branch" "$branch"

    [ -n $XDG_PROJECTS_DIR ] || set XDG_PROJECTS_DIR $HOME/repos
    [ -e "$XDG_PROJECTS_DIR" ] || mkdir "$XDG_PROJECTS_DIR"
    cd "$XDG_PROJECTS_DIR"

    git clone --depth 1 $__branch -- $url $path
    [ -n "$path" ] && cd "$path" || cd (ls -N1 --sort time | head -n1)
end
