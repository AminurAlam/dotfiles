function update -d "system update with just one command"
    set -x CARGO_BUILD_WARNINGS allow

    : =================================== GIT REPOS ==================================
    string pad -Cc= -w$COLUMNS " GIT REPOS "

    if pidof ssh-agent &>/dev/null && not ssh-add -l &>/dev/null
        ssh-add ~/.ssh/git_ed25519
    end

    if set -q TERMUX_VERSION
        for repo in dotfiles kt helix-fork yazi-plugins
            pushd ~/repos/$repo/ 2>/dev/null
            and { git pull origin --rebase; popd }
        end
    else
        set kanata_prev_commit (git -C ~/repos/kanata/ rev-parse HEAD)
        set helix_prev_commit (git -C ~/repos/helix-fork/ rev-parse upstream/HEAD)
        set yazi_prev_commit (git -C ~/repos/yazi-fork/ rev-parse upstream/HEAD)

        echo pulling changes...
        begin
            git -C ~/repos/kanata/ pull origin &>/dev/null &
            git -C ~/repos/helix-fork/ fetch upstream &>/dev/null &
            git -C ~/repos/yazi-fork/ fetch upstream &>/dev/null &
            wait git
        end

        if pushd ~/repos/kanata/ 2>/dev/null
            git log --pretty=nice -n (git rev-list --count $kanata_prev_commit..)
            popd
            printf "\033[0m"
        end

        if pushd ~/repos/helix-fork/ 2>/dev/null
            git rebase upstream/master
            git log --pretty=nice -n (git rev-list --count $helix_prev_commit..upstream/HEAD)
            popd
            printf "\033[0m"
        end

        if pushd ~/repos/yazi-fork/ 2>/dev/null
            git rebase upstream/main
            git log --pretty=nice -n (git rev-list --count $yazi_prev_commit..upstream/HEAD)
            popd
            printf "\033[0m"
        end
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
    echo

    : ===================================== CARGO ====================================
    string pad -Cc= -w$COLUMNS " CARGO "

    pushd ~/repos/kanata/ 2>/dev/null
    and { cargo install --locked --path .; popd }

    pushd ~/repos/kt/
    and { cargo install --locked --path .; popd }

    : ===================================== HELIX ====================================
    string pad -Cc= -w$COLUMNS " HELIX "

    pushd ~/repos/helix-fork/
    cargo install --locked --path helix-term
    { hx -g fetch; hx -g build } | rg -v '(Fetch|Build)ing grammars '
    popd

    : ===================================== YAZI =====================================
    string pad -Cc= -w$COLUMNS " YAZI "

    if pushd ~/repos/yazi-fork/ 2>/dev/null
        env YAZI_GEN_COMPLETIONS=1 cargo install --locked --path yazi-fm/
        cp yazi-boot/completions/yazi.fish ~/.config/fish/completions/yazi.fish

        env YAZI_GEN_COMPLETIONS=1 cargo install --locked --path yazi-cli/
        cp yazi-cli/completions/ya.fish ~/.config/fish/completions/ya.fish

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

    touch $XDG_STATE_HOME/time_since/update
end
