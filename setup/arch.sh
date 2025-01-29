### live boot
# sed -i 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' /etc/pacman.conf
# pacman -Sy archinstall
# archinstall

### post install
sudo pacman -Syu --needed fish git man-db eza fd git ripgrep git man-db base-devel ttf-sourcecodepro-nerd
# systemctl start NetworkManager.service
command -v fish && sudo chsh -s "$(command -v fish)"

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

git clone -q --depth 1 https://aur.archlinux.org/yay.git ~/repos/yay
cd ~/repos/yay || exit
makepkg -si

yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save
