set REPO_NAME ""
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL ""
set DEPENDENCIES binutils

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
