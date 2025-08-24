mkdir -p ~/{backup,bin,.ssh} ~/.local/{bin,share}

printf "LINKING CONFIG DIRECTORIES... "
for config in alacritty aria2 \
    btop \
    clangd \
    dunst \
    eza \
    fish fuzzel \
    gallery-dl gdb ghostty git glow \
    htop hypr \
    jj \
    kanata keepassxc kitty \
    lazygit \
    mgba mpv \
    newsboat niri npm nvim \
    pacman paru powershell python \
    qBittorrent \
    ruff \
    sqlite3 streamrip systemd \
    termux tmux \
    waybar wofi \
    xdg-desktop-portal xdg-desktop-portal-termfilechooser \
    yay yazi yt-dlp \
    zathura zellij

    # skip non-existing dirs
    [ -e ~/repos/dotfiles/$config ] || continue
    # unlink/relocate old directories in ~/.config
    [ -L ~/.config/$config ] && command unlink ~/.config/$config
    [ -d ~/.config/$config ] && command mv -f ~/.config/$config ~/backup/

    ln -fs ~/repos/dotfiles/$config ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
ln -fs ~/repos/dotfiles/other/clang-format ~/repos/.clang-format
ln -fs ~/repos/dotfiles/other/clang-format ~/.local/.clang-format
ln -fs ~/repos/dotfiles/other/curlrc ~/.config/.curlrc
ln -fs ~/repos/dotfiles/other/starship.toml ~/.config/starship.toml
ln -fs ~/repos/dotfiles/other/stylua.toml ~/.config/stylua.toml
ln -fs ~/repos/dotfiles/other/taplo.toml ~/.config/taplo.toml
# ln -fs ~/repos/dotfiles/other/ssh_config ~/.ssh/config # NOTE: do this manually
printf "done\n"


if set -q TERMUX_VERSION
    printf "LINKING TERMUX FILES... "
    ln -fs ~/repos/dotfiles/other/pacman.termux.conf $PREFIX/etc/pacman.conf
    ln -fs ~/repos/dotfiles/termux/colors.properties ~/.termux/colors.properties # https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/termux/shared/termux/TermuxConstants.java#L657
    ln -fs ~/repos/dotfiles/termux/termux.properties ~/.termux/termux.properties

    ln -fs ~/repos/dotfiles/scripts/bin/termux-url-opener ~/bin/termux-url-opener
    ln -fs ~/repos/dotfiles/scripts/bin/termux-file-editor ~/bin/termux-file-editor
    ln -fs ~/repos/dotfiles/scripts/bin/rish ~/.local/bin/rish
    ln -fs ~/repos/dotfiles/scripts/bin/tachi ~/.local/bin/tachi
    ln -fs ~/repos/dotfiles/scripts/bin/opendir ~/.local/bin/opendir
    printf "done\n"
end

printf "LINKING LINUX FILES...\n"
[ -e /etc/pacman.conf ] && sudo ln -fs ~/repos/dotfiles/other/pacman.arch.conf /etc/pacman.conf
ln -s ~/repos/dotfiles/applications ~/.local/share/
ln -fs ~/repos/dotfiles/scripts/bin/cbzcover ~/.local/bin/cbzcover

rmdir --ignore-fail-on-non-empty ~/{backup,bin}
