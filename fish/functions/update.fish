function update -d "system update with just one command"

    echo =================================== GIT REPOS ==================================
    if set -q TERMUX_VERSION
        pushd ~/repos/dotfiles/
        and git pull origin
        popd

        pushd ~/repos/helix-fork
        and git pull origin
        popd

        pushd ~/repos/yazi-plugins/
        and git pull origin
        popd
    end

    echo ==================================== MIRRORS ===================================
    not set -q TERMUX_VERSION && set repo (printf "%s\n" core extra | fzf)
    and curl https://archlinux.org/mirrorlist/?country={BD,CN,IN,NP}"&protocol=http&protocol=https&ip_version=4&ip_version=6" \
        | sed '/^##/d; s/^#//' \
        | rankmirrors -n 10 -m 5 -r $repo - \
        | sudo tee /etc/pacman.d/mirrorlist

    echo ==================================== PACMAN ====================================
    command -vq yay
    and yay -Syu
    or pacman -Syu

    echo ===================================== NVIM =====================================
    [ $USER = fisher ]
    and nvim +'lua vim.pack.update(nil, {force = true})' +q
    or nvim +'lua vim.pack.update(nil, {force = true, target = "lockfile"})' +q
    # nvim +'require("nvim-treesitter").update():wait(300000)' +q

    echo ===================================== CARGO ====================================

    set -q TERMUX_VERSION
    or cargo install --locked --git https://git.gay/stella/niri-ipc-windowlayout

    set -q TERMUX_VERSION
    and cargo install --locked --git https://codeberg.org/AminurAlam/kt

    echo ===================================== HELIX ====================================
    if [ "$(read -P "update helix? [y/N] ")" = y ]
        pushd ~/repos/helix-fork
        set -q TERMUX_VERSION && git pull origin
        HELIX_DISABLE_AUTO_GRAMMAR_BUILD=1 cargo install --path helix-term --locked
        popd
    end
    { hx -g fetch; hx -g build } | rg -v '(Fetch|Build)ing grammars '

    echo ===================================== YAZI =====================================
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

    echo =================================== YAZI PKGS ==================================
    set -q TERMUX_VERSION
    and ya pkg install --discard
    or ya pkg upgrade --discard

    echo ====================================== ZMX =====================================
    if set -q TERMUX_VERSION
        pushd $HOME/repos/dotfiles/scripts/build/zmx-bin/
        makepkg -si --needed
        popd
    end

    echo =================================== MANPAGES ===================================
    makewhatis -D 2>| pv -ls(man -k . | count) >/dev/null

    echo =============================== FISH COMPLETIONS ===============================
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
