function gcp -a url path branch -d "git clone wrapper"
    if [ -z "$url" ]
        command -vq wl-paste && set url (wl-paste)
        command -vq termux-clipboard-get && set url (termux-clipboard-get)

        [ -z "$url" ] && echo "ERROR: no url given" && return
        # TODO: check if its a proper url
    end
    [ -n "$branch" ] && set -f branch "--branch" "$branch"
    [ -e "$HOME/repos" ] || mkdir "$HOME/repos"
    set is_gh string match -qr -- "^https://github.com/" "$url"

    # TODO: only for github links
    $is_gh && set url (string replace -r -- 'https://([^/]+)/([^/]+)/([^/]+).*' 'https://$1/$2/$3' "$url")

    if $is_gh && [ -e ~/.ssh/github_ed25519 ]
        set url (string replace -r -- 'https://github.com/([^/]+)/([^/]+)' 'git@github.com:$1/$2.git' "$url")
    # else if [ -e ~/.ssh/gitlab_ed25519 ] && string match -q -- "https://gitlab.com/" "$url"
    # else if [ -e ~/.ssh/codeberg_ed25519 ] && string match -q -- "https://codeberg.org/" "$url"
    # else if [ -e ~/.ssh/sourcehut_ed25519 ] && string match -q -- "https://git.sr.ht/" "$url"
    end

    cd "$HOME/repos"

    echo $url
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
