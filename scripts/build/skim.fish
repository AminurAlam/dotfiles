set REPO_NAME skim-fork
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/AminurAlam/skim.git"
set DEPENDENCIES binutils rust

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
        [ "$(read -P 'run `git-pull`? [y/N] ')" = y ] && git pull origin
    else
        git clone --depth 1 "$REPO_URL" "$REPO_PATH"
        cd "$REPO_PATH"
    end
end

function build
    [ "$(read -P 'run `cargo-clean`? [y/N] ')" = y ] && cargo clean
    cargo build --release || exit
end

function post_build
    target/release/sk --version || return 1
    command cp -i target/release/sk ~/.local/bin/
end


pre_build

build

post_build
