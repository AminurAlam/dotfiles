### live boot
# sed -i 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' /etc/pacman.conf
# pacman -Sy archinstall
# archinstall

# systemctl start NetworkManager.service
# systemctl unmask power-profiles-daemon.service 
# systemctl start power-profiles-daemon.service 

### post install
sudo pacman -Syu --needed alacritty base-devel \
    eza fd fish flatpak git man-db power-profiles-daemon ripgrep thunderbird tmux vlc \
    noto-fonts noto-fonts-cjk noto-fonts-emoji

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
yay -S tree-sitter-git neovim-git librewolf-bin anki-bin vesktop-bin
# https://catppuccin.github.io/discord/dist/catppuccin-macchiato-blue.theme.css


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

