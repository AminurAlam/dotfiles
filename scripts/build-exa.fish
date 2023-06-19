pacman -S --noconfirm --needed rust binutils

if [ -d "$HOME/repos/exa-fork/" ]
    cd "$HOME/repos/exa-fork/"
    git pull origin
else
    git clone --depth 1 "https://github.com/AminurAlam/exa.git" "$HOME/repos/exa-fork/"
    cd "$HOME/repos/exa-fork/"
end

cargo build --release
