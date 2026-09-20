function update -d "system update with just one command"

    string pad -C -c= -w$COLUMNS " REFLECTOR "
    if not set -q TERMUX_VERSION && [ "$(read -P "run reflector? [y/N] ")" = y ]
        sudo reflector \
            --sort rate \
            --country India,China,Bangladesh \
            --save /etc/pacman.d/mirrorlist \
            -p http,https
    end

    string pad -C -c= -w$COLUMNS " PACMAN "
    command -vq yay
    and yay -Syu
    or pacman -Syu

    string pad -C -c= -w$COLUMNS " NVIM "
    [ $USER = fisher ]
    and nvim +'lua vim.pack.update()'
    or nvim +'lua vim.pack.update(nil, {target = "lockfile"})'

    string pad -C -c= -w$COLUMNS " GIT REPOS "
    if set -q TERMUX_VERSION
        pushd ~/repos/dotfiles/
        and git pull origin
        popd

        pushd ~/repos/yazi-plugins/
        and git pull origin
        popd
    end

    string pad -C -c= -w$COLUMNS " CARGO "

    set -q TERMUX_VERSION
    or cargo install --locked --git https://git.gay/stella/niri-ipc-windowlayout

    set -q TERMUX_VERSION
    and cargo install --locked --git https://codeberg.org/AminurAlam/kt

    string pad -C -c= -w$COLUMNS " HELIX "
    if [ "$(read -P "update helix? [y/N] ")" = y ]
        pushd ~/repos/helix-fork
        set -q TERMUX_VERSION && git pull origin
        HELIX_DISABLE_AUTO_GRAMMAR_BUILD=1 cargo install --path helix-term --locked
        popd
    end
    { hx -g fetch; hx -g build } | rg -v '(Fetch|Build)ing grammars '

    # cargo install --profile opt --config 'build.rustflags="-C target-cpu=native"' --locked \
    #     --git https://github.com/helix-editor/helix helix-term

    string pad -C -c= -w$COLUMNS " YAZI "
    if not set -q TERMUX_VERSION
        pushd ~/repos/yazi-fork/
        git fetch upstream
        git rebase upstream/main
        set changes (git rev-list --count  "origin..upstream")

        printf "%d new changes\n" "$changes"

        if [ "$changes" -gt 0 ] \
                && [ "$(read -P "update yazi? [y/N] ")" = y ]
            cargo build --release --locked
            mv target/release/yazi target/release/ya $CARGO_HOME/bin/
        end
        popd
    end

    string pad -C -c= -w$COLUMNS " YAZI PKGS "
    set -q TERMUX_VERSION
    and ya pkg install --discard
    or ya pkg upgrade --discard

    string pad -C -c= -w$COLUMNS " ZMX "
    if set -q TERMUX_VERSION
        pushd $HOME/repos/dotfiles/scripts/build/zmx-bin/
        makepkg -si
        popd
    end

    string pad -C -c= -w$COLUMNS " MANPAGES "
    command -vq sudo
    and sudo makewhatis
    or makewhatis

    string pad -C -c= -w$COLUMNS " FISH COMPLETIONS "
    fish_update_completions

    # string pad -C -c= -w$COLUMNS " BIOME "
    if false && [ $USER = fisher ]
        pushd $HOME/.local/cache/temp/

        set local_version (biome -V | rg --replace '$1' '^Version: (.*)$')
        curl -o api.json -#L \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            https://api.github.com/repos/biomejs/biome/releases
        set latest_version (
            jq -r '.[0].name' api.json \
            | rg --replace '$1' '^Biome CLI v(.*)$')

        if [ "$local_version" != "$latest_version" ]
            pushd ~/.local/bin/
            and begin
                rm biome
                aria2c -o biome \
                    https://github.com/biomejs/biome/releases/download/%40biomejs%2Fbiome%40$latest_version/biome-linux-x64
                chmod +x biome
            end
            popd
            printf '\n'
        else
            printf "BiomeJS is already up-to-date: %s\n" $latest_version
        end
        popd
    end
end
