if command -sq apt
    alias pi "apt install"
    alias pr "apt remove"
    alias pf "apt search"
    alias pa "apt show"
    function pu
        echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
        apt update && apt upgrade
    end
else if command -sq pacman
    abbr pi "pacman -S"
    abbr pr "pacman -Rs"
    abbr pf "pacman -Ss"
    abbr pu "pacman -Syu"
    abbr pa "pacman -Si"
end

if command -sq pip
    alias pyi "pip install"
    alias pyu "pip install --upgrade"
    alias pyr "pip uninstall"
    alias pyf "pip search"
end

if command -sq npm
    alias ni "npm install --location global"
    alias nr "npm uninstall"
    alias nu "npm update"
else if command -sq yarn
    # TODO
end

if command -sq cargo
    alias ci "cargo install"
    alias cr "cargo uninstall"
    alias cf "cargo search --limit 30"
end
