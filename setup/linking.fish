mkdir -p ~/{backup,bin} ~/.local/{bin,share}

printf "LINKING CONFIG DIRECTORIES... "
for config in alacritty aria2 \
    btop \
    clangd \
    dunst \
    eza \
    fish foot fuzzel \
    gallery-dl gdb ghostty git glow \
    helix htop hypr \
    jj \
    kanata keepassxc kitty \
    lazygit librewolf \
    mgba mpv \
    newsboat newsraft niri npm nvim \
    pacman paru powershell python \
    qalculate qBittorrent \
    ruff \
    sqlite3 swayimg systemd \
    termux tmux tombi \
    waybar wofi \
    xdg-desktop-portal xdg-desktop-portal-termfilechooser \
    yay yazi yt-dlp \
    zathura zellij

    [ -e ~/repos/dotfiles/$config ] || continue
    [ -L ~/.config/$config ] && command unlink ~/.config/$config
    [ -d ~/.config/$config ] && command mv -f ~/.config/$config ~/backup/

    ln -nfs ~/repos/dotfiles/$config ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
ln -nfs ~/repos/dotfiles/other/clang-format ~/repos/.clang-format
ln -nfs ~/repos/dotfiles/other/clang-format ~/.local/.clang-format
ln -nfs ~/repos/dotfiles/other/curlrc ~/.config/.curlrc
ln -nfs ~/repos/dotfiles/other/starship.toml ~/.config/starship.toml
ln -nfs ~/repos/dotfiles/other/stylua.toml ~/.config/stylua.toml
ln -nfs ~/repos/dotfiles/other/taplo.toml ~/.config/taplo.toml
ln -nfs ~/repos/dotfiles/other/user-dirs.dirs ~/.config/user-dirs.dirs
# ln -nfs ~/repos/dotfiles/other/ssh_config ~/.ssh/config # NOTE: do this manually
printf "done\n"

if set -q TERMUX_VERSION
    printf "LINKING TERMUX FILES... "
    ln -nfs ~/repos/dotfiles/other/pacman.termux.conf $PREFIX/etc/pacman.conf
    ln -nfs ~/repos/dotfiles/termux/colors.properties ~/.termux/colors.properties # https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/termux/shared/termux/TermuxConstants.java#L657
    ln -nfs ~/repos/dotfiles/termux/termux.properties ~/.termux/termux.properties
    ln -nfs ~/repos/dotfiles/scripts/bin/termux-url-opener ~/bin/termux-url-opener
    ln -nfs ~/repos/dotfiles/scripts/bin/termux-file-editor ~/bin/termux-file-editor
    ln -nfs ~/repos/dotfiles/scripts/bin/tachi ~/.local/bin/tachi
    ln -nfs ~/repos/dotfiles/scripts/bin/rat ~/.local/bin/rat
    printf "done\n"
end

printf "LINKING MORE CONFIG FILES...\n"
[ -e /etc/pacman.conf -a (path resolve /etc/pacman.conf) != $HOME/repos/dotfiles/other/pacman.arch.conf ]
and sudo ln -nfs ~/repos/dotfiles/other/pacman.arch.conf /etc/pacman.conf
[ -e /etc/ly/config.ini -a (path resolve /etc/ly/config.ini) != $HOME/repos/dotfiles/ly/config.ini ]
and sudo ln -nfs ~/repos/dotfiles/ly/config.ini /etc/ly/config.ini
ln -nTfs ~/repos/dotfiles/applications ~/.local/share/applications
ln -nTfs ~/repos/yazi-plugins ~/repos/dotfiles/yazi/plugins

printf "LINKING... "
ln -nfs ~/repos/dotfiles/scripts/bin/ctl ~/.local/bin/ctl
ln -nfs ~/repos/dotfiles/scripts/bin/md2typ ~/.local/bin/md2typ
printf "done\n"

rmdir --ignore-fail-on-non-empty ~/{backup,bin}
