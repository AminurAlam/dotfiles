set REPO_NAME ""
set REPO_PATH "$HOME/repos/$REPO_NAME"
set REPO_URL ""
set DEPENDENCIES binutils

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
    if [ -e Makefile ]
        [ "$(read -P 'run `make distclean`? [y/N] ')" = y ] && make distclean
        make || exit
        make install
    else if [ -e Cargo.toml ]
        [ "$(read -P 'run `cargo-clean`? [y/N] ')" = y ] && cargo clean
        cargo build --release || exit
    end
end

function post_build
    path/to/bin --version || return 1
    command cp -i path/to/bin ~/.local/bin/
end


pre_build

build

post_build
