set dotfiles $HOME/repos/dotfiles
set main /sdcard/main/termux
set packages dust libgit fd git neovim openssh ripgrep starship lua-language-server termux-api zoxide
set font_url "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFont-Regular.ttf"
set dotfiles_url "https://github.com/AminurAlam/dotfiles.git"

mkdir -p $HOME/backup/ $HOME/.shortcuts/ $HOME/.local/{share,bin,cache}/

printf "INSTALLING NEW PACKAGES...\n"
pacman -Syu --noconfirm --needed $packages || begin
    printf "failed, try installing manually:
    $(set_color $fish_color_command)pacman $(set_color $fish_color_option)-Syu --needed $(set_color $fish_color_param)$packages $(set_color normal)\n"
    exit
end
printf "done\n"

if not command -sq python
    printf "INSTALLING PYTHON... "
    pacman -S --needed python >/dev/null
end

if command -sq python && not command -sq pip
    printf "INSTALLING PIP & CLANG "
    pacman -S --needed python-pip >/dev/null
end

if command -sq python && command -sq pip
    printf "INSTALLING REQUESTS & DEFLACUE "
    pip install requests deflacue
end

printf "DOWNLOADING DOTFILES... "
[ -d "$dotfiles" ] && command rm -fr "$dotfiles" &>/dev/null
git clone -q --depth 1 "$dotfiles_url" "$dotfiles"
printf "done\n"

printf "LINKING CONFIG DIRECTORIES... "
for config in aria2 fish git mutt newsboat npm nvim python
    [ -e "$dotfiles/$config" ] || continue
    command mv -f ~/.config/$config ~/backup/ &>/dev/null # NOTE: dont rm rf this, it can be a symlink
    ln -fs "$dotfiles/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
ln -fs "$dotfiles/starship.toml" ~/.config/starship.toml
ln -fs "$dotfiles/termux/colors.properties" ~/.termux/colors.properties
ln -fs "$dotfiles/termux/termux.properties" ~/.termux/termux.properties
printf "done\n"


printf "ADDING BINARIES & WIDGET... " # TODO: support different architecture
if [ -d "$main/bin/" ]
    command cp -fr $main/bin/universal/* ~/.local/bin/
    set -l arch (uname -m | sed 's/^arm.*/arm/')
    [ -d "$main/bin/$arch/" ] && command cp -fr "$main/bin/$arch/"* ~/.local/bin/
end
if [ -d "$main/widget/" ]
    command cp -fr $main/widget/* ~/.shortcuts/
end
chmod +x ~/.local/bin/* ~/.shortcuts/*
printf "done\n"

if [ -e "$main/bin.sha256" ]
    sha256sum --check $main/bin.sha256 2>/dev/null | awk -F / '{print "  "$9}'
else
    printf "bin.sha256 is missing\n"
end

printf "CLEANUP... "
truncate -s 0 "$PREFIX"/etc/motd*
[ -d ~/storage/ ] && command rm -fr ~/storage/
rmdir --ignore-fail-on-non-empty ~/backup/
command mv "$HOME/.bash_history" ~/.local/cache/ &>/dev/null
echo "done\n"

[ -e "$HOME/.termux_authinfo" ] || passwd
[ "$(read -P 'downlad font? [y/N] ')" = y ] && curl -so ~/.termux/font.ttf "$font_url" &>/dev/null

# TODO: proot-distro and gui
