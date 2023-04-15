set dotfiles  $HOME/repos/dotfiles
set main  /sdcard/main/termux
set packages  dust exa fd git neomutt neovim-nightly openssh ripgrep starship zoxide lua-language-server termux-api

mkdir -p $HOME/backup/ $HOME/.shortcuts/ $HOME/.local/{share,bin}/

printf "UPDATING DATABASE...\n"
pacman -Syu --noconfirm &>/dev/null || begin
    printf "update failed, try updating manually:
    $(set_color $fish_color_command)pacman $(set_color $fish_color_option)-Syu $(set_color normal)\n"
    exit
end

printf "INSTALLING NEW PACKAGES...\n"
pacman -S --noconfirm --needed $packages &>/dev/null || begin
    printf "installation failed, try installing manually:
    $(set_color $fish_color_command)pacman $(set_color $fish_color_option)-S --needed $(set_color $fish_color_param)$packages $(set_color normal)\n"
    exit
end

if not command -sq python
    printf "INSTALLING PYTHON "
    pacman -S --needed python >/dev/null
end

if command -sq python && not command -sq pip
    printf "INSTALLING PIP & CLANG "
    pacman -S --needed python-pip >/dev/null
end

if command -sq python && command -sq pip
    printf "INSTALLING REQUESTS & DEFLACUE "
    pip install requests deflacue >/dev/null
end

printf "DOWNLOADING DOTFILES...\n"
[ -d "$dotfiles" ] && command mv "$dotfiles" ~/backup/ &>/dev/null  # TODO: maybe just delete it
git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" "$dotfiles"

printf "LINKING CONFIG DIRECTORIES...\n"
for config in fish git mutt newsboat npm nvim python
    [ -e "$dotfiles/$config" ] || continue
    command mv -f ~/.config/$config ~/backup/ &>/dev/null
    ln -fs "$dotfiles/$config" ~/.config/
end

printf "LINKING CONFIG FILES...\n"
command mv ~/.termux/*.properties ~/.config/starship.toml ~/backup/ &>/dev/null
ln -fs "$dotfiles/starship.toml" ~/.config/starship.toml
ln -fs "$dotfiles/termux/colors.properties" ~/.termux/colors.properties
ln -fs "$dotfiles/termux/termux.properties" ~/.termux/termux.properties


printf "LOCAL BINARIES...\n"
[ -d "$main/bin/" ] &&
    command cp -fr $main/bin/* ~/.local/bin/ &&
    chmod +x ~/.local/bin/*
[ -d "$main/widget/" ] &&
    command cp -fr $main/widget/* ~/.shortcuts/ &&
    chmod +x ~/.shortcuts/*
[ -e "$main/bin-checksums" ] &&
    sha256sum --check $main/bin-checksums | awk -F '/' '{print $9}' ||
    printf "no checksum"

printf "CLEANUP...\n"
truncate -s 0 $PREFIX/etc/motd $PREFIX/etc/motd.sh &>/dev/null
[ -d ~/storage/ ] && command rm -fr ~/storage/
rmdir --ignore-fail-on-non-empty ~/backup/ &>/dev/null


printf "FINAL INSTRUCTIONS:
add `rclone.conf` manually:
    $(set_color $fish_color_command)cp $(set_color $fish_color_quote)$main/rclone.conf ~/.termux/font.ttf$(set_color normal)
change font manually:
    $(set_color $fish_color_command)cp $(set_color $fish_color_option)-f $(set_color $fish_color_quote)'$main/font.ttf' ~/.termux/font.ttf$(set_color normal)
zoom in and out to fix screen
"
