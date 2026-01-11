function gcp -a url path branch -d "git clone wrapper"
    if [ -z "$url" ]
        command -vq wl-paste && set url (wl-paste)
        command -vq termux-clipboard-get && set url (termux-clipboard-get)

        [ -z "$url" ] && echo "ERROR: no url given" && return
    end

    if [ -n "$branch" ]
        # set branch from cli
        set -f branch --branch "$branch"
    else if string match -rq -- '/tree/[^/]+$' "$url"
        # set branch from url
        set -f branch --branch (string match -r -- '/tree/[^/]+$' "$url" | cut -d/ -f 3)

        if string match -rq -- AminurAlam/termux-packages/tree/ "$url"
            # set path for commonly forked project
            set -f path "tpkg-$branch[2]"
        end
    end

    # normalize url
    set url (string replace -r -- 'https://([^/]+)/([^/]+)/([^/]+).*' 'https://$1/$2/$3' "$url")

    if string match -qr -- "^https://github.com/" "$url"
        [ -e ~/.ssh/github_ed25519 ]
        and set url (string replace -r -- 'https://github.com/([^/]+)/([^/]+)' 'git@github.com:$1/$2.git' "$url")
    else if string match -qr -- "^https://codeberg.org/" "$url"
        [ -e ~/.ssh/codeberg_ed25519 ]
        and set url (string replace -r -- 'https://codeberg.org/([^/]+)/([^/]+)' 'ssh://git@codeberg.org/$1/$2.git' "$url")
    end

    cd "$HOME/repos"

    echo -- " \$ $(set_color $fish_color_command)git $(set_color $fish_color_param)clone $(set_color $fish_color_option)$branch[1] $(set_color $fish_color_param)$branch[2] $(set_color $fish_color_option)-- $(set_color $fish_color_param)$url $path$(set_color normal)"

    # TODO: set path to name-repo if repo already exists
    git clone --depth 1 $branch -- $url $path
    and begin
        if [ -n "$path" ]
            cd "$path"
        else
            cd (ls -AN1 --sort time | head -n1)
        end

        # explore with file manager
        if command -vq yazi
            type -q y && y || yazi
        end
    end
end
