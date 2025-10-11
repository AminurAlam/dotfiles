if not [ -d ~/repos/nvim-fork/ ]
    gcp https://github.com/AminurAlam/neovim nvim-fork
end

cd ~/repos/nvim-fork/ || exit
git fetch upstream
git rebase upstream/master

cd ~/repos/dotfiles/scripts/build/nvim/ || exit
makepkg -si
