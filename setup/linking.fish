printf "LINKING CONFIG DIRECTORIES... "
for config in alacritty aria2 clangd eza fish gdb git htop lazygit newsboat npm nvim procs python ruff streamrip termux tmux yazi yt-dlp zellij
    # skip non-existing dirs
    [ -e "~/repos/$config" ] || continue
    # unlink/relocate old directories in ~/.config
    [ -L "~/.config/$config" ] && command unlink ~/.config/$config
    [ -d "~/.config/$config" ] && command mv -f ~/.config/$config ~/backup/

    ln -fs "~/repos/$config" ~/.config/
end
printf "done\n"

printf "LINKING CONFIG FILES... "
    ln -fs "~/repos/other/clang-format" ~/.clang-format
    ln -fs "~/repos/other/curlrc" ~/.config/.curlrc
    ln -fs "~/repos/other/tidal-dl.json" ~/.config/.tidal-dl.json
    ln -fs "~/repos/other/starship.toml" ~/.config/starship.toml
    ln -fs "~/repos/other/stylua.toml" ~/.config/stylua.toml
    ln -fs "~/repos/other/taplo.toml" ~/.config/taplo.toml
    if [ (uname -o) = Android ]
        ln -fs "~/repos/other/termux_pacman.conf" $PREFIX/etc/pacman.conf
        ln -fs "~/repos/termux/colors.properties" ~/.termux/colors.properties # https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/termux/shared/termux/TermuxConstants.java#L657
        ln -fs "~/repos/termux/termux.properties" ~/.termux/termux.properties
    end
printf "done\n"
