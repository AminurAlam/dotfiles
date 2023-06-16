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

set -gx UV_USE_IO_URING 0
set -l EXTRA_ARGS " \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DENABLE_JEMALLOC=OFF \
-DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt) \
-DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge) \
-DXGETTEXT_PRG=$(command -v xgettext) "

switch "$TERMUX_MAIN_PACKAGE_FORMAT"
    case pacman
        pacman -Syu
        pacman -S --noconfirm --needed binutils clang cmake gettext libuv make ninja openssl pkg-config
    case apt
        pkg install binutils clang cmake gettext libuv make ninja openssl pkg-config
    case "*"
        exit
end

if not [ -d "$HOME/repos/nvim-fork/" ]
    git clone --depth 1 "https://github.com/AminurAlam/neovim.git" "$HOME/repos/nvim-fork/"
end

cd "$HOME/repos/nvim-fork/"
git pull origin || exit # NOTE: always run this script in a subshell

[ "$(read -P 'run `make distclean`? [y/N] ')" = "y" ] && make distclean
make CMAKE_EXTRA_FLAGS="$EXTRA_ARGS"
and command cp -i build/bin/nvim ~/.local/bin/nvim
