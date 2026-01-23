#!/data/data/com.termux/files/usr/bin/fish

mkdir -p $HOME/{repos,backup} $HOME/.local/{share,bin,cache} $HOME/.local/share/zoxide

printf "INSTALLING BASE PACKAGES...\n"
pacman -Syu --noconfirm --needed fd git ripgrep termux-api termux-auth yazi || exit
clear

printf "DOWNLOADING DOTFILES...\n"
for name in dotfiles yazi-plugins
    [ -d "$HOME/repos/$name" ]
    or git clone --depth 1 https://github.com/AminurAlam/$name.git $HOME/repos/$name || exit
end

fish "$HOME/repos/dotfiles/setup/linking.fish" || exit
[ -e "$HOME/repos/dotfiles/yazi/plugins" ] && ya pkg install || exit
clear

printf "CHANGING FONT... "
[ -e "$HOME/.termux/font.ttf" ]
or curl -#Lqo "$HOME/.termux/font.ttf" \
    "https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/Ligatures/Medium/JetBrainsMonoNerdFont-Medium.ttf"
clear

[ -e "$HOME/.termux_authinfo" ] || begin
    printf "ADDING PASSWORD...\n"
    passwd
    clear
end

printf "CLEANUP..."
fd motd $PREFIX/etc/ -x truncate -s 0

[ -d ~/storage/ ] && begin
    fd -tsymlink . --search-path ~/storage/ -x unlink
    rmdir ~/storage/
end

fd -HI -tdirectory -x rmdir --ignore-fail-on-non-empty --parents

rm -f "$HOME/bootstrap-aarch64.zip"

clear

: # making sure the script returns 0
