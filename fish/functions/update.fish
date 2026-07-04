function update -d "system update with just one command"

    string pad -C -c= -w$COLUMNS " PACMAN "
    command -vq yay
    and yay -Syu
    or pacman -Syu

    string pad -C -c= -w$COLUMNS " NVIM "
    [ $USER = fisher ]
    and nvim +'lua vim.pack.update()'
    or nvim +'lua vim.pack.update(nil, {target = "lockfile"})'

    string pad -C -c= -w$COLUMNS " CARGO "

    cargo install --locked --git https://git.gay/stella/niri-ipc-windowlayout

    set -q TERMUX_VERSION
    and cargo install --locked --git https://codeberg.org/AminurAlam/kt

    cargo install --profile opt --config 'build.rustflags="-C target-cpu=native"' --locked \
        --git https://github.com/helix-editor/helix helix-term

    string pad -C -c= -w$COLUMNS " YAZI PKGS "
    set -q TERMUX_VERSION
    and ya pkg install --discard
    or ya pkg upgrade --discard

    string pad -C -c= -w$COLUMNS " MANPAGES "
    command -vq sudo
    and sudo makewhatis
    or makewhatis

    string pad -C -c= -w$COLUMNS " FISH COMPLETIONS "
    fish_update_completions

    string pad -C -c= -w$COLUMNS " GIT REPOS "
    if set -q TERMUX_VERSION
        cd ~/repos/dotfiles/
        and git pull origin

        cd ~/repos/yazi-plugins/
        and git pull origin end
    end

    # string pad -C -c= -w$COLUMNS " BIOME "
    if false && [ $USER = fisher ]
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
            and begin
                rm biome
                aria2c -o biome \
                    https://github.com/biomejs/biome/releases/download/%40biomejs%2Fbiome%40$latest_version/biome-linux-x64
                chmod +x biome
            end
            printf '\n'
        else
            printf "BiomeJS is already up-to-date: %s\n" $latest_version
        end
    end
end
