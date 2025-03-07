mkdir -p ~/backup ~/.ssh

printf "LINKING CONFIG DIRECTORIES... "
for config in alacritty aria2 btop clangd dunst eza fish gdb git htop hypr keepassxc lazygit mpv newsboat npm nvim python ruff streamrip termux tmux waybar wofi yazi yt-dlp zathura zellij
    # skip non-existing dirs
    [ -e ~/repos/dotfiles/$config ] || continue
    # unlink/relocate old directories in ~/.config
    [ -L ~/.config/$config ] && command unlink ~/.config/$config
    [ -d ~/.config/$config ] && command mv -f ~/.config/$config ~/backup/

    ln -fs ~/repos/dotfiles/$config ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs ~/repos/dotfiles/other/clang-format  ~/.clang-format
    ln -fs ~/repos/dotfiles/other/curlrc        ~/.config/.curlrc
    ln -fs ~/repos/dotfiles/other/tidal-dl.json ~/.config/.tidal-dl.json
    ln -fs ~/repos/dotfiles/other/starship.toml ~/.config/starship.toml
    ln -fs ~/repos/dotfiles/other/stylua.toml   ~/.config/stylua.toml
    ln -fs ~/repos/dotfiles/other/taplo.toml    ~/.config/taplo.toml
    ln -fs ~/repos/dotfiles/other/ssh-config    ~/.ssh/config
    if [ -e /etc/pacman.conf ]
        sudo ln -fs ~/repos/dotfiles/other/pacman.arch.conf /etc/pacman.conf
    end
    if [ (uname -o) = Android ]
        mkdir -p ~/bin

        ln -fs ~/repos/dotfiles/scripts/termux-url-opener ~/bin/
        ln -fs ~/repos/dotfiles/scripts/termux-file-editor ~/bin/
        ln -fs ~/repos/dotfiles/other/pacman.termux.conf $PREFIX/etc/pacman.conf
        ln -fs ~/repos/dotfiles/termux/colors.properties ~/.termux/colors.properties # https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/termux/shared/termux/TermuxConstants.java#L657
        ln -fs ~/repos/dotfiles/termux/termux.properties ~/.termux/termux.properties
    end
printf "done\n"

rmdir --ignore-fail-on-non-empty ~/backup
