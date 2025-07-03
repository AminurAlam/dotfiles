function gcp -a url path branch -d "git clone wrapper"
    [ -z "$url" ] && echo "ERROR: no url given" && return
    [ -n "$branch" ] && set -f branch "

    " "$branch"
    [ -e "$HOME/repos" ] || mkdir "$HOME/repos"

    set url (string replace -r -- 'https://([^/]+)/([^/]+)/([^/]+).*' 'https://$1/$2/$3' "$url")

    if [ -e ~/.ssh/github_ed25519 ] && string match -q -- "https://github.com/" "$url"
        set url (string replace -r -- 'https://github.com/([^/]+)/([^/]+)' 'git@gittub.com:$1/$2.git' "$url")
    # else if [ -e ~/.ssh/gitlab_ed25519 ] && string match -q -- "https://gitlab.com/" "$url"
    # else if [ -e ~/.ssh/codeberg_ed25519 ] && string match -q -- "https://codeberg.org/" "$url"
    # else if [ -e ~/.ssh/sourcehut_ed25519 ] && string match -q -- "https://git.sr.ht/" "$url"
    end

    cd "$HOME/repos"

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
