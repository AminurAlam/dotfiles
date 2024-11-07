function gcp -a url path branch
    [ -z "$url" ] && echo "ERROR: no url given" && return
    [ -n "$branch" ] && set -f branch "--branch" "$branch"
    set -q XDG_PROJECTS_DIR || set XDG_PROJECTS_DIR $HOME/repos
    [ -e "$XDG_PROJECTS_DIR" ] || mkdir "$XDG_PROJECTS_DIR"

    cd "$XDG_PROJECTS_DIR"

    git clone --depth 1 $branch -- $url $path
    and set success true

    set -q path
    and cd "$path" &>/dev/null && return

    [ "$success" = true ]
    and cd (ls -AN1 --sort time | head -n1) && return
end
