function passh -d "patch from ssh"
    cd ~/repos/dotfiles
    ssh phone git -C \~/repos/dotfiles diff $argv | git apply --check
    and ssh phone git -C \~/repos/dotfiles diff $argv | git apply --check
    or printf "\ncould not apply the patch, check the following:
    - ssh is working properly
    - there are no conflicts
    - pass filenames as args if necessary\n"

    for file in (ssh phone git -C \~/repos/dotfiles status -s | rg --replace '' '^\?\? ')
        [ -e "~/repos/dotfiles/$file" ]
        or scp "phone:~/repos/dotfiles/$file" ~/repos/dotfiles/$file
    end
end
