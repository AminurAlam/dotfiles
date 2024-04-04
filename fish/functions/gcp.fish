function gcp -a url path branch
    [ -n "$branch" ] && set -l branch "--branch" "$branch"
    [ -n $XDG_PROJECTS_DIR ] || set XDG_PROJECTS_DIR $HOME/repos
    [ -e "$XDG_PROJECTS_DIR" ] || mkdir "$XDG_PROJECTS_DIR"

    cd "$XDG_PROJECTS_DIR"

    git clone --depth 1 $branch -- $url $path
    and set success true

    [ -n "$path" ]
    and cd "$path" &>/dev/null && return

    [ "$success" = true ]
    and cd (ls -N1 --sort time | head -n1) && return
end
