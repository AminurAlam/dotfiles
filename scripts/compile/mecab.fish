set REPO_NAME mecab
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE"
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

    if [ -d "$XDG_PROJECTS_DIR/mecab-0.996" ]
        cd "$XDG_PROJECTS_DIR/mecab-0.996"
    else
        cd $XDG_PROJECTS_DIR || exit
        if command -vq aria2c
            aria2c "$REPO_URL"
        else if command -vq wget
            wget "$REPO_URL"
        else
            echo "install aria2c or wget"
            exit
        end
        tar zxfv mecab-0.996.tar.gz
        rm mecab-0.996.tar.gz
        cd mecab-0.996/
    end
end

function build
    ./configure --build aarch64-unknown-linux
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
