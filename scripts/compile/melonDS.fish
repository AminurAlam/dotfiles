
set REPO_NAME "melonDS"
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL ""
set DEPENDENCIES binutils cmake extra-cmake-modules git libpcap sdl2 qt5-base qt5-qtbase-cross-tools qt5-multimedia libslirp libarchive zstd

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
        [ "$(read -P 'run `git-pull`? [y/N] ')" = y ] && git pull --deepen 0 origin
    else
        git clone --depth 1 "$REPO_URL" "$REPO_PATH"
        cd "$REPO_PATH"
    end
end

function build
end

function post_build
end


pre_build

build

post_build
