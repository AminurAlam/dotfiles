#!/data/data/com.termux/files/usr/bin/fish

# packages
set base_packages eza fd git ripgrep termux-api termux-auth
set extra_packages clang dust python python-pip python-ensurepip-wheels python-yt-dlp renameutils starship yazi zoxide
set python_packages "git+https://github.com/nathom/streamrip.git@dev" "git+https://github.com/AminurAlam/deflacue.git"

# urls
set url_font "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Medium.ttf"
set url_dotfiles "https://github.com/AminurAlam/dotfiles.git"
set url_neovim "https://github.com/AminurAlam/neovim.git"
set url_fish_setup "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"
set url_mbz "https://github.com/AminurAlam/musicbrainzpy.git"

# paths
[ -z "$XDG_PROJECTS_DIR" ] && set -gx XDG_PROJECTS_DIR "$HOME/repos"
set dots "$XDG_PROJECTS_DIR/dotfiles" # NOTE: make sure this is a full path



command mkdir -p $XDG_PROJECTS_DIR $HOME/backup/ $HOME/.local/{share,bin,cache} $HOME/.local/share/zoxide

printf "INSTALLING BASE PACKAGES...\n"
    pacman -Syu --noconfirm --needed $base_packages || exit

printf "DOWNLOADING DOTFILES... "
    if [ -d "$dots" ]
        pushd "$dots"
        git pull -q origin
        popd
    else
        git clone -q --depth 1 "$url_dotfiles" "$dots"
    end
printf "done\n"

printf "INSTALLING EXTRA PACKAGES...\n"
pacman -S --needed $extra_packages 

[ -e ~/repos/dotfiles/setup/linking.fish ] && fish ~/repos/dotfiles/setup/linking.fish

printf "CHANGING FONT... "
    command rm -f ~/.termux/font.ttf
    curl -Lqs -o ~/.termux/font.ttf "$url_font" &>/dev/null
printf "done\n"

[ -e "$HOME/.termux_authinfo" ] || begin
    printf "ADDING PASSWORD...\n"
    passwd
end

printf "SETTING UP YAZI...\n"
    command -vq ya
    and ya pack -u 2>/dev/null | rg Upgrading

printf "CLEANUP... "
    truncate -s 0 "$PREFIX"/etc/motd*
    [ -d ~/storage/ ] && for path in ~/storage/*
        [ -L "$path" ] && unlink "$path"
    end
    set needs_cleaning ~/backup/** ~/storage
    command rmdir --ignore-fail-on-non-empty --parents $needs_cleaning &>/dev/null
    command rm -f "$HOME/bootstrap-aarch64.zip"
printf "done\n"


function setup_latex
    pacman -Syu --noconfirm --needed texlive-installer || exit

    # tlmgr update --all
    termux-install-tl --profile "$XDG_PROJECTS_HOME/dotfiles/scripts/texlive.profile"
    termux-patch-texlive
end

function setup_lsp
    set prerequisites python python-pip nodejs
    set pkg_lsp ruff clang lua-language-server taplo shellcheck shellharden shfmt
    set npm_lsp basedpyright prettier bash-language-server vscode-html-languageservice

    pacman -Syu --noconfirm --needed $pkg_lsp
    pacman -Syu --noconfirm --needed $prerequisites

    npm install -g $npm_lsp

    termux-fix-shebang ~/.local/share/npm/bin/*
end

# TODO: put scripts in bin

: # making sure the script returns 0
