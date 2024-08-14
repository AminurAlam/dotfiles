set REPO_NAME mecab
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE"
set DEPENDENCIES binutils make cmake

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

    cd $XDG_PROJECTS_DIR || exit
    aria2c "$REPO_URL"
    tar zxfv mecab-0.996.tar.gz
    rm mecab-0.996.tar.gz
    cd mecab-0.996/
end

function build
    ./configure --build arm
    patch src/dictionary.cpp <~/repos/dotfiles/scripts/patches/mecab-src-dictionary.cpp.diff
    make CFLAGS=-Wno-register CXXFLAGS=-Wno-register CPPFLAGS=-Wno-register
    make check
    make install prefix=$PREFIX
end

function post_build
    mecab --version || return 1
end


pre_build
build
post_build
