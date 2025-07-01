status is-interactive || exit
command -vq tmux || exit

if not tmux has-session -t conf 2>/dev/null
    command -vq lazygit
    and set lazygit \-n lazygit lg \; new-window \-c ~/repos/dotfiles/
    tmux new-session -c ~/repos/dotfiles/ -ds conf $lazygit
end

# TODO: kavita-bin
# TODO: firefox-syncstorage https://github.com/mozilla-services/syncserver
if [ (uname -o) = GNU/Linux ] && not tmux has-session -t servers 2>/dev/null
    set anki_port 8100
    set kiwix_port 8101
    set komga_port 8102
    set kavita_port 8102
    set ffsync_port 8103 # TODO: sqlite!!
    # kiwix-manage ~/Downloads/main/zim/library_zim.xml add ~/Downloads/main/zim/*.zim
    # install mwoffliner
    # archwiki: https://browse.library.kiwix.org/viewer#archlinux_en_all_maxi_2025-05
    # bulbapedia: https://browse.library.kiwix.org/viewer#bulbagarden_en_all_nopic_2022-02
    # bulbapedia+images: https://browse.library.kiwix.org/viewer#bulbagarden_en_all_maxi_2022-02
    # manpages: https://browse.library.kiwix.org/viewer#devdocs_en_man_2025-04
    # japping: https://browse.library.kiwix.org/viewer#japanese.stackexchange.com_mul_all_2024-05

    # TODO: convert to service files
    tmux new-session -c ~ -ds servers -n stat btop \; \
        new-window -n anki "env \
            SYNC_PORT=$anki_port \
            SYNC_BASE=$HOME/.local/state/anki-syncserver \
            SYNC_USER1=a@a.aa:aaaa anki --syncserver" # \; \
        # new-window -n kiwix "kiwix-serve --port $kiwix_port $HOME/Downloads/main/zim/*.zim" \; \
        # new-window -n komga "env \
        #     SERVER_PORT=$komga_port \
        #     KOMGA_CONFIGDIR=$HOME/.local/share/komga komga"
end
