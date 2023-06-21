# -DENABLE_JEMALLOC=OFF
# -DGPERF_PRG=$TERMUX_PKG_HOSTBUILD_DIR/deps/usr/bin/gperf
# -DLUA_PRG=$TERMUX_PKG_HOSTBUILD_DIR/deps/usr/bin/luajit
# -DPKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
# -DLUAJIT_INCLUDE_DIR=$TERMUX_PREFIX/include/luajit-2.1
# -DCOMPILE_LUA=OFF "

set DEPENDENCIES binutils clang cmake gettext libtreesitter libuv make ninja openssl pkg-config
set UV_USE_IO_URING 0
set INSTALL_PATH "$PREFIX/share"

set SYSINIT "set mouse=a
map <ScrollWheelUp> <C-Y>
imap <ScrollWheelUp> <C-X><C-Y>
map <ScrollWheelDown> <C-E>
imap <ScrollWheelDown> <C-X><C-E>"

set EXTRA_ARGS " \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$INSTALL_PATH \
-DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt) \
-DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge) \
-DXGETTEXT_PRG=$(command -v xgettext) "

function pre_build
    switch "$TERMUX_MAIN_PACKAGE_FORMAT"
        case pacman
            pacman -S --noconfirm --needed $DEPENDENCIES
        case apt
            pkg install $DEPENDENCIES
        case "*"
            exit
    end
end

function build
    if [ -d "$HOME/repos/nvim-fork/" ]
        cd "$HOME/repos/nvim-fork/"
        git pull origin
    else
        git clone --depth 1 "https://github.com/AminurAlam/neovim.git" "$HOME/repos/nvim-fork/"
        cd "$HOME/repos/nvim-fork/"
    end

    [ "$(read -P 'run `make distclean`? [y/N] ')" = y ] && make distclean

    make CMAKE_EXTRA_FLAGS="$EXTRA_ARGS" || exit
    make install
end

function post_build
    command rm -fr $INSTALL_PATH/nvim
    command mkdir -pv $INSTALL_PATH/nvim/

    command cp -r runtime/ $INSTALL_PATH/nvim/runtime/
    echo "$SYSINIT" >$INSTALL_PATH/nvim/sysinit.vim
    command cp -i build/bin/nvim ~/.local/bin/nvim
end

function check
    build/bin/nvim --version
    # [ "$(read -P 'run `make test`? [y/N] ')" = y ] && make test
end


pre_build

build

post_build

check
