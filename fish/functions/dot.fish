function dot
    set -f dirs "$HOME/.config/fish/" "$HOME/.config/nvim/"
    rm -rf "$HOME/repos/dotfiles/fish/" "$HOME/repos/dotfiles/nvim/"

    for dir in $dirs
        yes | command cp -rf "$dir" "$HOME/repos/dotfiles/"
    end
    rm -rf "$HOME/repos/dotfiles/nvim/plugin/"

    read choice -f -P "done copying, would you like to commit? [Y/n] "

    if test -z $choice -o $choice = "y"
        cd $HOME/repos/dotfiles/
        git add .
        git commit
        git push origin
    end
end
