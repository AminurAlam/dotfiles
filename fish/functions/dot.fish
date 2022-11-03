function dot
    set -f dirs "$HOME/.config/fish/" "$HOME/.config/nvim/"
    rm -rf "$HOME/repos/dotfiles/fish/" "$HOME/repos/dotfiles/nvim/"

    for dir in $dirs
        yes | cp -rf "$dir" "$HOME/repos/dotfiles/"
    end

    read choice -f -P "done copying, would you like to commit? [Y/n] "

    if test -z $choice -o $choice = "y"
        cd $HOME/repos/dotfiles/
        git add .
        git commit
        git push origin
    end
end
