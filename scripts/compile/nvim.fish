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

    # fixes phantom process killing
    command -vq rish && rish -c "settings put global settings_enable_monitor_phantom_procs false"

    # checking connection
    ping -qc 5 -i 0.2 -- raw.githubusercontent.com || begin
        printf "connection to `raw.githubusercontent.com` failed\n"
        printf "try using a VPN\n"
        exit
    end

    # TODO: fix downloading full repo
    if [ -d "$REPO_PATH" ]
        cd "$REPO_PATH"
        [ "$(read -P 'run `git-pull`? [y/N] ')" = y ] && git pull --deepen 0 --depth 1 origin
    else
        git clone --depth 1 --branch custom "$REPO_URL" "$REPO_PATH"
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
