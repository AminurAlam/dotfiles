pacman -S --noconfirm --needed rust binutils

if [ -d "$HOME/repos/skim-fork/" ]
    cd "$HOME/repos/skim-fork/"
    git pull origin
else
    git clone --depth 1 "https://github.com/AminurAlam/skim.git" "$HOME/repos/skim-fork/"
    cd "$HOME/repos/skim-fork/"
end

cargo build --release
