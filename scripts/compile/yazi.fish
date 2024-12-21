set REPO_NAME "yazi-fork"
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/AminurAlam/yazi"
set DEPENDENCIES binutils gcc-default rust

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
    set -gx YAZI_GEN_COMPLETIONS 1
    cargo install --path yazi-fm
    cargo install --path yazi-cli
end

function post_build
    yazi --version || return 1
    ya --version || return 1
    cp -v yazi-boot/completions/yazi.fish $XDG_CONFIG_HOME/fish/completions/
    cp -v yazi-cli/completions/ya.fish $XDG_CONFIG_HOME/fish/completions/
end


pre_build

build

post_build
