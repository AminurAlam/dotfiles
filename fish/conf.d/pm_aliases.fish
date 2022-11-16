if command -sq apt
    alias pin="apt install"
    alias pun="apt remove"

    alias pls="apt list --installed"
    alias pla="apt list"
    alias plu="apt list --upgradeable"
    alias pfd="apt search"
    alias pinf="apt show"
else if command -sq pacman
    # TODO
    alias pin="pacmam -S"
    alias pun="pacman -Rs"

    alias pls="pacman -Q"
    # alias pla="apt list"
    # alias plu="apt list --upgradeable"
    alias pfd="pacman -Ss"
    # alias pinf="apt show"
end
if command -sq pip
    alias pyin="pip install"
    alias pydl="pip download"
    alias pyup="pip install --upgrade"
    alias pyun="pip uninstall"

    alias pyls="pip list"
    alias pylo="pip list -o"
    alias pylu="pip list -o"
    alias pyfd="pip search"
end

if command -sq npm
    alias nin="npm install"
    alias nun="npm uninstall"
    alias nup="npm update"

    alias nls="npm ls"
    alias nig="npm install --location global"

    alias nrun="npm run"
    alias ntest="npm test"
    alias nstart="npm start"
else if command -sq yarn
    # TODO
end

if command -sq cargo
    alias cin="cargo install"
    alias cun="cargo uninstall"
    alias cfd="cargo search --limit 30"

    alias cnew="cargo new"  # create new project
    alias crun="cargo run"  # run w/wo binary
    alias cbuild="cargo build"  # compile binary in target/debug/…
    alias crelease="cargo build --release"  # compile binary in target/release/…
end

function pup
    echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    apt update && apt upgrade
end
