set REPO_NAME luvi luvit lit
set REPO_PATH "$HOME/.local/bin"
set REPO_URL "https://gist.githubusercontent.com/cattokomo/7f25b518e3ce22f7abe4d1bb11001628/raw/8184d6742ed5ab507725c13b5cccad500e004f18/install-luvit-for-termux.sh"
set DEPENDENCIES clang cmake make openssl binutils perl libuv

function pre_build
    if command -vq apt
        set -f pm apt install
    else if command -vq pacman
        set -f pm pacman -S --noconfirm --needed
    else if command -vq dnf
        set -f pm dnf install
    else
        printf "cannot determine package manager\n"
        exit
    end

    $pm -- $DEPENDENCIES

    [ -d "$REPO_PATH" ] || mkdir "$REPO_PATH"
    cd "$REPO_PATH" || exit

    for repo in $REPO_NAME
        [ -d "$REPO_PATH/$repo-build" ]
        and yes | rm -fr -- "$REPO_PATH/$repo-build"
        git clone --depth 1 --recursive "https://github.com/luvit/$repo" "$repo-build"
    end
end

function build
    printf "building luvi...\n"
    cd "$REPO_PATH/luvi-build" || exit
    make regular || exit
    make luvi || exit
    mv build/luvi "$REPO_PATH"

    printf "building lit...\n"
    cd "$REPO_PATH/lit-build" || exit
    "$REPO_PATH/luvi" . -- make . ./lit "$REPO_PATH/luvi" || exit
    mv lit "$REPO_PATH"

    printf "building luvit...\n"
    cd "$REPO_PATH/luvit-build" || exit
    "$REPO_PATH/lit" make . ./luvit "$REPO_PATH/luvi" || exit
    mv luvit "$REPO_PATH"

    cd "$REPO_PATH"
end

function post_build
    for repo in $REPO_NAME
        echo
        "$REPO_PATH/$repo" --version
    end
end


pre_build

build

post_build
