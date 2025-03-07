set REPO_NAME mecab
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/taku910/mecab.git"
set DEPENDENCIES binutils make cmake
# NOTE: manga_ocr deps
# pacman -S python-numpy python-pillow python-torch

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

    if [ -d "$REPO_PATH" ]
        cd "$REPO_PATH"
        [ "$(read -P 'run `git-pull`? [y/N] ')" = y ] && git pull --deepen 0 --depth 1 origin
    else
        git clone --depth 1 "$REPO_URL" "$REPO_PATH"
        cd "$REPO_PATH"
    end
end

function build
    cd "mecab"
    pwd
    # curl -Lo config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
    # curl -Lo config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'

    ./configure --build aarch64-unknown-linux --prefix $PREFIX
    patch src/dictionary.cpp <~/repos/dotfiles/scripts/patches/mecab-src-dictionary.cpp.diff
    make CXXFLAGS='-Wno-register -mno-outline-atomics'
    make check || exit
    make install prefix=$PREFIX
end

function post_build
    mecab --version || return 1
end


pre_build
build
post_build
