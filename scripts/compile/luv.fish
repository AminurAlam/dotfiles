set REPO_NAME luvi luvit lit
# set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
# set REPO_URL ""
set DEPENDENCIES clang cmake make openssl binutils perl libuv

function pre_build
    if command -vq apt
        [ (uname -o) = Android ] && apt instal -- $DEPENDENCIES || sudo apt install -- $DEPENDENCIES
    else if command -vq pacman
        pacman -S --noconfirm --needed -- $DEPENDENCIES
    else if command -vq dnf
        dnf install -- $DEPENDENCIES
    else
        printf "cannot determine package manager\n"
        exit
    end

    [ -d "$HOME/.local/bin" ] || mkdir "$HOME/.local/bin"
    cd "$HOME/.local/bin"
end

function build
    curl -LO "https://gist.githubusercontent.com/cattokomo/7f25b518e3ce22f7abe4d1bb11001628/raw/8184d6742ed5ab507725c13b5cccad500e004f18/install-luvit-for-termux.sh"
    bash install-luvit-for-termux.sh
end

function post_build
    echo
    lit --version
    echo
    luvi --version
    echo
    luvit --version
    rm install-luvit-for-termux.sh
end


pre_build

build

post_build
