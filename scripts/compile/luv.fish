set REPO_NAME luvi luvit lit
# set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
# set REPO_URL ""
set DEPENDENCIES clang cmake make openssl binutils perl libuv

function pre_build
    if command -vq pacman
        pacman -S --noconfirm --needed -- $DEPENDENCIES
    else if command -vq apt
        pkg install -- $DEPENDENCIES
    else
        exit
    end

    for repo in $REPO_NAME
        git clone --recursive --depth 1 "https://github.com/luvit/$repo" "$XDG_PROJECTS_DIR/$repo-src"
    end
end

function build
    cd "$XDG_PROJECTS_DIR/luvi-src"

    make regular
    make test
    make luvi

    mv build/luvi ../
    cd ../

    ./luvi lit-src -- make lit-src
end

function post_build
    luvi --version || return 1
    command mv -i luvi ~/.local/bin/
end


pre_build

build

post_build
