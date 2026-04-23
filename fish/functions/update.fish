function update -d "system update with just one command"

    printf "=============== PACMAN ===============\n"

    command -vq yay
    and yay -Syu
    or pacman -Syu

    printf "=============== NVIM ===============\n"

    [ $USER = fisher ]
    and nvim +'lua vim.pack.update()'
    or nvim +'lua vim.pack.update(nil, {target = "lockfile"})'

    printf "=============== BIOME ===============\n"

    if [ $USER = fisher ]
        cd $HOME/.local/cache/temp/

        set local_version (biome -V | rg --replace '$1' '^Version: (.*)$')
        curl -o api.json -#L \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            https://api.github.com/repos/biomejs/biome/releases
        set latest_version (
            jq -r '.[0].name' api.json \
            | rg --replace '$1' '^Biome CLI v(.*)$')

        if [ "$local_version" != "$latest_version" ]
            cd ~/.local/bin/
            and aria2c -o biome \
                https://github.com/biomejs/biome/releases/download/@biomejs/biome@$latest_version/biome-linux-x64
            chmod +x biome
        else
            printf "BiomeJS is already up-to-date: %s\n" $latest_version
        end
    end

    printf "=============== YAZI PKGS ===============\n"
    set -q TERMUX_VERSION
    and ya pkg install --discard
    or ya pkg upgrade --discard

    printf "=============== MANPAGES ===============\n"
    command -vq sudo
    and sudo makewhatis
    or makewhatis

    printf "=============== FISH COMPLETIONS ===============\n"
    fish_update_completions

    printf "=============== GIT REPOS ===============\n"
    # TODO: add stuff

    printf "=============== NEWSRAFT ===============\n"
    newsraft -e purge-abandoned
end
