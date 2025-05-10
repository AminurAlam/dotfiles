# TODO: auto convert https to ssh
function gcp -a url path branch -d "git clone wrapper"
    [ -z "$url" ] && echo "ERROR: no url given" && return
    [ -n "$branch" ] && set -f branch "--branch" "$branch"
    set -q XDG_PROJECTS_DIR || set XDG_PROJECTS_DIR $HOME/repos
    [ -e "$XDG_PROJECTS_DIR" ] || mkdir "$XDG_PROJECTS_DIR"

    cd "$XDG_PROJECTS_DIR"

    git clone --depth 1 $branch -- $url $path
    and set success true

    if [ "$success" = true ]
        if [ -n "$path" ]
            cd "$path"
        else
            cd (ls -AN1 --sort time | head -n1)
        end
        # explore with yazi
        type -q y && y
    end
end
