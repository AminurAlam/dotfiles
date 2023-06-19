# -DCMAKE_BUILD_TYPE=RelWithDebInfo
# -DENABLE_JEMALLOC=OFF
# -DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt)
# -DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge)
# -DGPERF_PRG=$TERMUX_PKG_HOSTBUILD_DIR/deps/usr/bin/gperf
# -DLUA_PRG=$TERMUX_PKG_HOSTBUILD_DIR/deps/usr/bin/luajit
# -DPKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
# -DXGETTEXT_PRG=$(command -v xgettext)
# -DLUAJIT_INCLUDE_DIR=$TERMUX_PREFIX/include/luajit-2.1
# -DCOMPILE_LUA=OFF "

set DEPENDENCIES binutils clang cmake gettext libtreesitter libuv make ninja openssl pkg-config
set -gx UV_USE_IO_URING 0
set EXTRA_ARGS " \
-DCMAKE_BUILD_TYPE=Release \
-DENABLE_JEMALLOC=OFF \
-DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt) \
-DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge) \
-DXGETTEXT_PRG=$(command -v xgettext) "


switch "$TERMUX_MAIN_PACKAGE_FORMAT"
    case pacman
        pacman -S --noconfirm --needed $DEPENDENCIES
    case apt
        pkg install $DEPENDENCIES
    case "*"
        exit
end

if [ -d "$HOME/repos/nvim-fork/" ]
    cd "$HOME/repos/nvim-fork/"
    git pull origin
else
    git clone --depth 1 "https://github.com/AminurAlam/neovim.git" "$HOME/repos/nvim-fork/"
    cd "$HOME/repos/nvim-fork/"
end

[ "$(read -P 'run `make distclean`? [y/N] ')" = "y" ] && make distclean

make CMAKE_EXTRA_FLAGS="$EXTRA_ARGS" || exit
make install

# POST INSTALL STUFF

command cp -i build/bin/nvim ~/.local/bin/nvim

# replace old runtime with new one
command rm -fr $PREFIX/share/nvim/runtime/
command cp -r runtime/ $PREFIX/share/nvim/

echo "\" touchscreen stuff
set mouse=a
map <ScrollWheelUp> <C-Y>
imap <ScrollWheelUp> <C-X><C-Y>
map <ScrollWheelDown> <C-E>
imap <ScrollWheelDown> <C-X><C-E>" >$PREFIX/share/nvim/sysinit.vim
