pacman -Syu --noconfirm --needed texlive-installer || exit

#tlmgr update --all
termux-install-tl --profile "$XDG_PROJECTS_HOME/dotfiles/scripts/texlive.profile"
termux-patch-texlive
