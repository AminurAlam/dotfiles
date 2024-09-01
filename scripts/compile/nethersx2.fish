set REPO_NAME NetherSX2-patch
set REPO_PATH "$XDG_PROJECTS_DIR/$REPO_NAME"
set REPO_URL "https://github.com/Trixarian/NetherSX2-patch"
set DEPENDENCIES aapt2 wget apksigner # apksigner|openjdk-17

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
        git pull --deepen 0 --depth 1 origin
    else
        git clone --depth 1 "$REPO_URL" "$REPO_PATH"
        cd "$REPO_PATH"
    end
end

function build
    ./patch-apk.sh || exit
end

function post_build
    [ -e "15210-v1.5-4248-patched.apk" ]
    and open 15210-v1.5-4248-patched.apk
    or printf "ERROR: no output file generated\n"

    printf "cleaning up $REPO_PATH ...\n"
    rm -rfI "$REPO_PATH"
    pacman -Rs aapt2 wget apksigner
end


pre_build

build

post_build
