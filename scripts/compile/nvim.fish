set REPO_NAME nvim-fork
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/AminurAlam/neovim.git"
set DEPENDENCIES binutils clang cmake gettext libtreesitter libuv make ninja openssl pkg-config

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

    [ -d "$REPO_PATH" ] || git clone --branch custom "$REPO_URL" "$REPO_PATH"
    cd "$REPO_PATH"
    git remote show upstream &>/dev/null || git remote add upstream "https://github.com/neovim/neovim.git"
    git fetch upstream
    [ "$(read -P 'run `git-merge`? [y/N] ')" = y ] && git merge upstream/master
end

function build
    set UV_USE_IO_URING 0

    [ "$(read -P 'run `make distclean`? [y/N] ')" = y ] && make distclean

    make || exit
    make install CMAKE_INSTALL_PREFIX="$PREFIX/"
end

function post_build
    printf "========================== BUILD COMPLETE ==========================\n"
    # set UV_USE_IO_URING 0
    set VIMRUNTIME runtime/

    build/bin/nvim -V1 --version || return 1
    build/bin/nvim --clean --headless +"helptags $PREFIX/share/nvim/runtime/doc/ | q!"
    lsof ~/.local/bin/nvim &>/dev/null &&
        printf "nvim is currently running\n" ||
        command cp -i build/bin/nvim ~/.local/bin/
    printf "====================================================================\n"
end


pre_build

build

post_build
