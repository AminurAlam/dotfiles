set REPO_NAME nvim-fork
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/AminurAlam/neovim.git"
set DEPENDENCIES binutils clang cmake gettext libtreesitter libuv make ninja openssl pkg-config

function pre_build
    if command -vq pacman
        pacman -S --noconfirm --needed -- $DEPENDENCIES
    else if command -vq apt
        pkg install -- $DEPENDENCIES
    else
        exit
    end

    if [ -d "$REPO_PATH" ]
        cd "$REPO_PATH"
        [ "$(read -P 'run `git-pull`? [y/N] ')" = y ] && git pull --deepen 0 origin
    else
        git clone --depth 1 "$REPO_URL" "$REPO_PATH"
        cd "$REPO_PATH"
    end
end

function build
    set UV_USE_IO_URING 0

    [ "$(read -P 'run `make distclean`? [y/N] ')" = y ] && make distclean

    make || exit
    make install CMAKE_INSTALL_PREFIX="$PREFIX/"
end

function post_build
    set UV_USE_IO_URING 0
    set VIMRUNTIME runtime/

    build/bin/nvim --version || return 1
    build/bin/nvim --clean --headless +'helptags runtime/doc/ | q!'
    command cp -i build/bin/nvim ~/.local/bin/
end


pre_build

build

post_build
