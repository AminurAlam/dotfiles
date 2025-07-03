set REPO_NAME nvim-fork
set REPO_PATH "$HOME/repos/$REPO_NAME"
set REPO_URL "git@github.com/AminurAlam/neovim.git"
set DEPENDENCIES binutils clang cmake gettext libunibilium libuv luajit luv \
    make ninja openssl pkg-config tree-sitter tree-sitter-parsers utf8proc

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
    git remote show | grep -q upstream || git remote add upstream "git@github.com:neovim/neovim.git"
    git fetch upstream
    git rebase upstream/master || begin
        printf "rebase failed...\n"
        printf "try running `git mergetool` `git rebase --continue`...\n"
        exit
    end
end

function build
    if [ -e build -o -e .deps ] && [ "$(read -P 'run `make distclean`? [y/N] ')" = y ]
        [ -e "$PREFIX/share/nvim" ] && rm -fr "$PREFIX/share/nvim/"
        make distclean
    end

    make BUNDLED_CMAKE_FLAG="-DUSE_BUNDLED=ON -DUSE_BUNDLED_LPEG=ON" || exit
    make install CMAKE_INSTALL_PREFIX="$PREFIX/"
end

function post_build
    [ -L "$PREFIX"/share/nvim/runtime/parser ] || ln -s "$PREFIX"/lib/tree_sitter "$PREFIX"/share/nvim/runtime/parser

    build/bin/nvim -V1 --version || return 1
end


[ "$argv[1]" = quick ] || pre_build

build

post_build
