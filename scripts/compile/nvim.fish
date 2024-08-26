set REPO_NAME nvim-fork
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/AminurAlam/neovim.git"
set DEPENDENCIES binutils clang cmake gettext libuv make ninja openssl pkg-config \
    tree-sitter-parsers libunibilium utf8proc

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

    [ -d "$REPO_PATH" ] || git clone --branch custom "$REPO_URL" "$REPO_PATH"
    cd "$REPO_PATH"
    git remote show upstream -n &>/dev/null || git remote add upstream "https://github.com/neovim/neovim.git"
end

function build
    if [ -e build -o -e .deps ] && [ "$(read -P 'run `make distclean`? [y/N] ')" = y ]
        [ -e "$PREFIX/share/nvim" ] && rm -fr "$PREFIX/share/nvim/"
        make distclean
    end

    # NOTE: this is for dynamic builds
    cmake -S cmake.deps -B .deps -G Ninja -DUSE_BUNDLED=OFF -DUSE_BUNDLED_LPEG=ON
    cmake --build .deps
    cmake -B build -G Ninja
    cmake --build build
    # make || exit # NOTE: this is for static builds
    make install CMAKE_INSTALL_PREFIX="$PREFIX/"
end

function post_build
    [ -L "$PREFIX"/share/nvim/runtime/parser ] && unlink "$PREFIX"/share/nvim/runtime/parser
    ln -s "$PREFIX"/lib/tree_sitter "$PREFIX"/share/nvim/runtime/parser

    build/bin/nvim -V1 --version || return 1
end


[ "$argv[1]" = quick ] || pre_build

build

post_build
