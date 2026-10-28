function update -d "system update with just one command"

    : =================================== GIT REPOS ==================================
    string pad -Cc= -w$COLUMNS " GIT REPOS "

    if pidof ssh-agent &>/dev/null && not ssh-add -l &>/dev/null
        ssh-add ~/.ssh/git_ed25519
    end

    if set -q TERMUX_VERSION
        pushd ~/repos/dotfiles/
        and { git pull origin; popd }

        pushd ~/repos/kt/
        and { git pull origin; popd }

        pushd ~/repos/helix-fork/
        and { git pull origin; popd }

        pushd ~/repos/yazi-plugins/
        and { git pull origin; popd }
    else
        pushd ~/repos/rust-glancer/
        and { git pull origin; popd }

        pushd ~/repos/kanata/
        and { git pull origin; popd }

        pushd ~/repos/helix-fork/
        and { git fetch upstream && git rebase upstream/master; popd }

        pushd ~/repos/yazi-fork/
        and { git fetch upstream && git rebase upstream/main; popd }
    end

    : ==================================== MIRRORS ===================================
    string pad -Cc= -w$COLUMNS " MIRRORS "

    not set -q TERMUX_VERSION && set repo (printf "%s\n" core extra | fzf)
    and curl -s https://archlinux.org/mirrorlist/?country={BD,CN,IN,NP}"&protocol=http&protocol=https&ip_version=4&ip_version=6" \
        | sed '/^##/d; s/^#//' \
        | rankmirrors -n 10 -m 5 -r $repo - \
        | sudo tee /etc/pacman.d/mirrorlist

    : ==================================== PACMAN ====================================
    string pad -Cc= -w$COLUMNS " PACMAN "

    command -vq yay
    and yay -Syu --ignore bibata-cursor-theme-bin,mecab-git,mpv-git,ttf-twemoji
    or pacman -Syu

    : ===================================== NVIM =====================================
    string pad -Cc= -w$COLUMNS " NVIM "

    [ "$USER" = fisher ]
    and nvim --headless +'lua vim.pack.update(nil, {force = true})' +'sleep 3' +q
    or nvim --headless +'lua vim.pack.update(nil, {force = true, target = "lockfile"})' +'sleep 3' +q
    # nvim +'require("nvim-treesitter").update():wait(300000)' +q

    : ===================================== CARGO ====================================
    string pad -Cc= -w$COLUMNS " CARGO "

    # pushd ~/repos/rust-glancer/
    # and { cargo install --locked --path crates/rust-glancer/; popd }

    pushd ~/repos/kanata/
    and { cargo install --locked --path .; popd }

    pushd ~/repos/kt/
    and { cargo install --locked --path .; popd }

    : ===================================== HELIX ====================================
    string pad -Cc= -w$COLUMNS " HELIX "

    pushd ~/repos/helix-fork
    cargo install --locked --path helix-term
    { hx -g fetch; hx -g build } | rg -v '(Fetch|Build)ing grammars '
    popd

    : ===================================== YAZI =====================================
    string pad -Cc= -w$COLUMNS " YAZI "

    if pushd ~/repos/yazi-fork/
        CARGO_BUILD_WARNINGS=allow cargo install --locked --path yazi-fm/
        CARGO_BUILD_WARNINGS=allow cargo install --locked --path yazi-cli/
        popd
    end

    set -q TERMUX_VERSION
    and ya pkg install --discard
    or ya pkg upgrade --discard

    : ====================================== ZMX =====================================
    string pad -Cc= -w$COLUMNS " ZMX "

    if set -q TERMUX_VERSION && pushd $HOME/repos/dotfiles/scripts/build/zmx-bin/
        makepkg -si --needed
        popd
    end

    : =================================== MANPAGES ===================================
    string pad -Cc= -w$COLUMNS " MANPAGES "

    MANPATH=(man -w) makewhatis -D 2>| pv -ls(man -k . | count) >/dev/null
    MANPATH=(man -w) fish_update_completions

    : ===================================== BIOME ====================================
    # string pad -Cc= -w$COLUMNS " BIOME "

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
