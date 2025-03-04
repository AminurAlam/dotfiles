### live boot
# sed -i 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' /etc/pacman.conf
# pacman -Sy archinstall
# archinstall

### post install
sudo pacman -Syu --needed alacritty base-devel \
    eza fd fish flatpak git man-db power-profiles-daemon ripgrep thunderbird tmux vlc yazi \
    noto-fonts noto-fonts-cjk noto-fonts-emoji

systemctl enable NetworkManager.service power-profiles-daemon.service
command -v fish && sudo chsh -s "$(command -v fish)"
mkdir -p ~/.local/share/fonts/ttf/SauceCodeProNerdFont
curl -Lqso ~/.local/share/fonts/ttf/SauceCodeProNerdFont/SauceCodeProNerdFont-Medium.ttf "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf" &>/dev/null
fc-cache -f

### aur helper
git clone -q --depth 1 https://aur.archlinux.org/yay.git ~/repos/yay
cd ~/repos/yay || exit
makepkg -si

yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save

### load more packages
yay -S tree-sitter-git neovim-git librewolf-bin # android-studio anki-bin vesktop-bin

printf "DOWNLOADING DOTFILES... "
if [ -d ~/repos/dotfiles ]; then
    pushd ~/repos/dotfiles
    git pull -q origin
    popd
else
    git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" ~/repos/dotfiles
fi
printf "done\n"
[ -e ~/repos/dotfiles/setup/linking.fish ] && fish ~/repos/dotfiles/setup/linking.fish

printf "SETTING UP YAZI...\n"
command -v ya &>/dev/null && ya pack -u 2>/dev/null | rg Upgrading


### run these funcs whenever you need
setup_lsp() {
    yay -S clang npm gopls basedpyright stylua lua-language-server ktlint \
        bash-language-server shfmt shellcheck shellharden ruff rust-analyzer taplo
}

setup_wine() {
    sudo pacman -S wine
    sudo pacman -S --needed --asdeps giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
        lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
        lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
        lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2-compat lib32-sdl2-compat
}
