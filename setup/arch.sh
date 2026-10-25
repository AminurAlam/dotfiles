setup_live_boot() {
    sed -i 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' /etc/pacman.conf
    pacman -Sy archinstall
    archinstall
}

setup_post_install() {
    sudo pacman -Syu --needed pacman-contrib
    curl https://archlinux.org/mirrorlist/?country={BD,CN,IN,NP}"&protocol=http&protocol=https&ip_version=4&ip_version=6" \
        | sed '/^##/d; s/^#//' \
        | rankmirrors -n 10 -m 5 -r $repo - \
        | sudo tee /etc/pacman.d/mirrorlist
    sudo pacman -Syu --needed base-devel fd fish foot git power-profiles-daemon ripgrep

    systemctl enable NetworkManager.service power-profiles-daemon.service
    command -v fish &>/dev/null && sudo chsh -s "$(command -v fish)"
    mkdir -p ~/.local/share/fonts/ttf/JetBrainsMono
    curl -Lqso ~/.local/share/fonts/ttf/JetBrainsMono/JetBrainsMonoNerdFont-Medium.ttf \
        "https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/Ligatures/Medium/JetBrainsMonoNerdFont-Medium.ttf" &>/dev/null
    fc-cache -f
}

setup_aur() {
    git clone -q --depth 1 https://aur.archlinux.org/yay.git ~/repos/yay
    cd ~/repos/yay || exit
    makepkg -si

    yay -Y --gendb
    yay -Syu --devel
    yay -Y --devel --save
}

setup_dotfiles() {
    printf "DOWNLOADING DOTFILES... "
    if [ -d ~/repos/dotfiles ]; then
        pushd ~/repos/dotfiles || return
        git pull -q origin
        popd || return
    elif [ -e ~/.ssh/git_ed25519 ]; then
        mkdir ~/repos
        git clone -q --depth 1 "git@codeberg.org:AminurAlam/dotfiles.git" ~/repos/dotfiles
    else; then
        mkdir ~/repos
        git clone -q --depth 1 "https://codeberg.org/AminurAlam/dotfiles.git" ~/repos/dotfiles
    fi
    printf "done\n"
    [ -e ~/repos/dotfiles/setup/linking.fish ] && fish ~/repos/dotfiles/setup/linking.fish
}
