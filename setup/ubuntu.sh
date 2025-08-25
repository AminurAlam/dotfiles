#!/usr/bin/env bash

clear
printf "ADDING FISH...\n"
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install fish git
sudo chsh -s "$(command -v fish)"
if ! command -v fish &>/dev/null; then
    printf "FISH NOT INSTALLED PROPERLY\n"
    exit
fi

clear
printf "CLONING DOTFILES...\n"
if [ -e ~/repos/dotfiles ]; then
    git -C ~/repos/dotfiles/ pull
else
    mkdir ~/repos
    git clone --depth 1 "https://github.com/AminurAlam/dotfiles.git" ~/repos/dotfiles
fi
if ! [ -e ~/repos/dotfiles ]; then
    printf "DOTFILES NOT CLONED PROPERLY\n"
    exit
fi

clear
printf "INSTALLING PACSTALL...\n"
# bash -c "$(curl -fsSL https://pacstall.dev/q/ppr)"
sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install || wget -q https://pacstall.dev/q/install -O -)"
if ! command -v pacstall &>/dev/null; then
    printf "PACSTALL NOT INSTALLED PROPERLY\n"
    exit
fi

clear
printf "INSTALLING PACKAGES...\n"
pacstall -I git neovim-git kanata-bin # alacritty librewolf-app eza-git fzf-bin tmux nerd-fonts:ttf-sourcecodepro-nerd
# curl -LsSf https://astral.sh/ruff/install.sh | sh
for pkg in git kanata nvim; do
    if ! command -v "$pkg" &>/dev/null; then
        printf "%s not installed properly\n" "$pkg"
        exit
    fi
done

clear
printf "LINKING DOTFILES...\n"
fish ~/repos/dotfiles/setup/linking.fish
for conf in alacritty fish nvim tmux yazi; do
    if ! [ -L ~/.config/$conf ]; then
        printf "%s not linked properly\n" "$conf"
        exit
    fi
done
