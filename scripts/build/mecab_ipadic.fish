set REPO_NAME mecab
set REPO_PATH "$HOME/repos/$REPO_NAME"
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
    cd mecab-ipadic || exit
    pwd
    # curl -Lo config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
    # curl -Lo config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'

    sed -i "s|^MECAB_DICT_INDEX=.*|MECAB_DICT_INDEX=$PREFIX/libexec/mecab/mecab-dict-index|g" configure configure.in
    ./configure --build aarch64-unknown-linux --prefix $PREFIX --libexec /data/data/com.termux/files/usr/libexec/mecab --with-charset utf-8
    make
    make check || exit
    make install prefix=$PREFIX
end

function post_build
    mecab --version || return 1
    mecab -Ochasen (echo 'MeCabは 京都大学情報学研究科−日本電信電話株式会社コミュニケーション科学基礎研究所共同研究ユニットプロジェクトを通じて開発されたオープンソース形態素解析エンジンです。' | psub)
end

pre_build
build
post_build
