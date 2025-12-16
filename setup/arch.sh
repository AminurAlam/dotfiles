setup_live_boot() {
    sed -i 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' /etc/pacman.conf
    pacman -Sy archinstall
    archinstall
}

setup_post_install() {
    sudo pacman -Syu --needed reflector
    sudo reflector --sort rate --country India,China,Bangladesh --save /etc/pacman.d/mirrorlist
    sudo pacman -Syu --needed base-devel fd fish foot git power-profiles-daemon ripgrep yazi

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
    else
        git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" ~/repos/dotfiles
    fi
    printf "done\n"
    [ -e ~/repos/dotfiles/setup/linking.fish ] && fish ~/repos/dotfiles/setup/linking.fish

    printf "SETTING UP YAZI...\n"
    command -v ya &>/dev/null && ya pack -u 2>/dev/null | rg Upgrading
}

setup_dev() {
    yay -S --needed tree-sitter neovim-git librewolf-bin # anki-bin vesktop-bin
    yay -S --needed basedpyright bash-language-server ccls clang lua-language-server \
        ruff rust-analyzer shellcheck shfmt stylua taplo termux-language-server tinymist \
        vscode-css-languageserver vscode-html-languageserver yaml-language-server
    npm -g i serve
}

setup_wine() {
    sudo pacman -S wine
    sudo pacman -S --needed --asdeps giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
        lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
        lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
        lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2-compat lib32-sdl2-compat
}

setup_de() {
    yay -S anki kiwix-tools komga kanata-bin
    yay -S xdg-desktop-portal-gnome xdg-desktop-portal-wlr # org.freedesktop.secrets
    systemctl --user enable {anki-syncserver,kanata,swaybg,waybar,xwayland-satellite,redlib,foot-server}.service
}
