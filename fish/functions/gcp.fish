function gcp -a url path branch -d "git clone wrapper"
    if [ -z "$url" ]
        command -vq wl-paste && set url (wl-paste)
        command -vq termux-clipboard-get && set url (termux-clipboard-get)

        [ -z "$url" ] && echo "ERROR: no url given" && return
    end
    [ -n "$branch" ] && set -f branch "--branch" "$branch"

    if string match -qr -- "^https://github.com/" "$url"
        set url (string replace -r -- 'https://([^/]+)/([^/]+)/([^/]+).*' 'https://$1/$2/$3' "$url")
        [ -e ~/.ssh/github_ed25519 ]
        and set url (string replace -r -- 'https://github.com/([^/]+)/([^/]+)' 'git@github.com:$1/$2.git' "$url")
    end

    cd "$HOME/repos"

    echo $url
    git clone --depth 1 $branch -- $url $path
    and begin
        if [ -n "$path" ]
            cd "$path"
        else
            cd (ls -AN1 --sort time | head -n1)
        end
        # explore with yazi
        type -q y && y
    end
end
