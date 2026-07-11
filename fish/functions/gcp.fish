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
    end

    # normalize url: user/repo/foo/bar/baz -> user/repo
    string match -q 'https://gitlab.*' "$url"
    or set url (string replace -r -- 'https://([^/]+)/([^/]+)/([^/]+).*' 'https://$1/$2/$3' "$url")

    # convert to ssh url
    set -f known '(codeberg.org|github.com|gitlab.com)'
    if [ -e ~/.ssh/git_ed25519 ] && string match -qr -- "^https://$known/" "$url"
        and set url (string replace -r -- "https://$known/([^/]+)/([^/]+)" 'git@$1:$2/$3.git' "$url")
    end

    cd "$HOME/repos"

    [ -z "$path" ]
    and set path (echo (string split / "$url")[-1] | rg --passthru --replace '' '.git$')
    [ -e "$path" ]
    and set path $path-(random)

    echo -- " \$ $(set_color $fish_color_command)git $(set_color $fish_color_param)clone $(set_color $fish_color_option)$branch[1] $(set_color $fish_color_param)$branch[2] $(set_color $fish_color_option)-- $(set_color $fish_color_param)$url $path$(set_color normal)"

    git clone --depth 1 $branch -- $url $path
    and begin
        echo $url >>$XDG_STATE_HOME/gcp.urls

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
