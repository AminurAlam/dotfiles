set REPO_NAME ""
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL ""
set DEPENDENCIES binutils

function pre_build
    command -vq sudo && set sudo sudo

    if command -vq apt
        set pm apt install
    else if command -vq pacman
        set pm pacman -S --noconfirm --needed
    else if command -vq dnf
        set pm dnf install
    else
        printf "what arcane package manager are you using\n"
        exit
    end

    $sudo $pm -- $DEPENDENCIES

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
