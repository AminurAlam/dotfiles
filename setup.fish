function setup-git
    printf "SETTING UP GIT...\n"

    mkdir -p $HOME/.config/git/ && touch $HOME/.config/git/config

    git config --global init.defaultBranch 'dev'
    git config --global user.name 'AminurAlam'
    git config --global user.email '64137875+AminurAlam@users.noreply.github.com'
    git config --global author.name 'AminurAlam'
    git config --global author.email '64137875+AminurAlam@users.noreply.github.com'
    git config --global commiter.name 'AminurAlam'
    git config --global commiter.email '64137875+AminurAlam@users.noreply.github.com'

    command rm -fr "$HOME/repos/dotfiles/" &> /dev/null
    git clone -q --depth 1 "https://github.com/AminurAlam/dotfiles.git" $HOME/repos/dotfiles/
end

function restore-configs
    printf "LINKING CONFIG FILES...\n"

    mkdir -p $HOME/.config/backup/ $HOME/.local/share/

    for config in fish newsboat npm nvim python
        [ -e "$HOME/repos/dotfiles/$config" ] || continue
        command mv -f "$HOME/.config/$config" $HOME/.config/backup/ &> /dev/null
        ln -fs "$HOME/repos/dotfiles/$config" "$HOME/.config/"
    end

    command rm -fr $HOME/.termux/*.properties $HOME/.config/starship.toml &> /dev/null
    ln -fs $HOME/repos/dotfiles/starship.toml            $HOME/.config/starship.toml
    ln -fs $HOME/repos/dotfiles/termux/colors.properties $HOME/.termux/colors.properties
    ln -fs $HOME/repos/dotfiles/termux/termux.properties $HOME/.termux/termux.properties

    rmdir --ignore-fail-on-non-empty $HOME/.config/backup/ &> /dev/null
end


printf "FETCHING UPDATES...\n"
yes | pacman -Syu &> /dev/null
yes | pacman -S dust exa fd git neovim-nightly rip ripgrep starship zoxide lua-language-server termux-api &> /dev/null

printf "install python related stuff?"
pacman -S python python-pip > /dev/null && pip install requests deflacue > /dev/null

setup-git
restore-configs

printf "LOCAL BINARIES...\n"
mkdir -p $HOME/.local/bin/
[ -d "/sdcard/main/bin/" ] && command cp -fr /sdcard/main/bin/* $HOME/.local/bin/
command -sq nvim && ln -fs (command -s nvim) "$HOME/.local/bin/termux-file-editor"
chmod +x $HOME/.local/bin/*

printf "NO MOTD...\n"
truncate -s 0 $PREFIX/etc/motd $PREFIX/etc/motd.sh &> /dev/null

printf "ADDING FONT...\n"
[ -e "/sdcard/main/Sauce Code Pro Nerd Font Complete Mono.ttf" ] && command cp -f "/sdcard/main/Sauce Code Pro Nerd Font Complete Mono.ttf" ~/.termux/font.ttf

printf "REMOVING ~/storage ...\n"
[ -d "$HOME/storage/" ] && command rm -fr "$HOME/storage/"
