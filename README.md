# configs found here

- [alacritty](https://alacritty.org/) - terminal emulator
- [anki](https://apps.ankiweb.net/) - flashcards
- [aria2](https://aria2.github.io/) - download manager
- [btop](https://github.com/aristocratos/btop) - system resource monitor
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html) - c formatter
- [clangd](https://clang.llvm.org/) - c++ lsp server
- [curl](https://curl.se/) - request url
- [delta](https://dandavison.github.io/delta/) - git diff pager
- [dircolors](https://www.gnu.org/software/coreutils/dircolors) - $LS_COLORS generator
- [dunst](https://dunst-project.org/) - notification daemon
- [eza](https://github.com/eza-community/eza) - replacement for ls
- [fish](https://fishshell.com/) :star2: - shell
- [fuzzel](https://codeberg.org/dnkl/fuzzel) - application launcher
- [fzf](https://junegunn.github.io/fzf/) - fuzzy finder
- [gallery-dl](https://github.com/mikf/gallery-dl) - program to download image-galleries
- [gdb](https://www.gnu.org/software/gdb/) - GNU Project debugger
- [ghostty](https://github.com/ghostty-org/ghostty) - terminal emulator
- [git](https://git-scm.com/) - vcs
- [glow](https://github.com/charmbracelet/glow) - Command-line markdown renderer
- [htop](https://htop.dev/) - process viewer
- [hyprland](https://hyprland.org/) :star2: - tiling wayland compositor
- [jujustu](https://github.com/jj-vcs/jj) -  vcs
- [kanata](https://github.com/jtroo/kanata) - keyboard customizer
- [keepassxc](https://keepassxc.org/) - password manager
- [kitty](https://github.com/kovidgoyal/kitty) - terminal emulator
- [lazygit](https://github.com/jesseduffield/lazygit) - ui for git
- [mgba](http://mgba.io) - GBA emulator
- [mpv](https://mpv.io) - media player
- [newsboat](https://newsboat.org/) :star2: - rss reader
- [niri](https://github.com/YaLTeR/niri) - scrollable-tiling wayland compositor
- [nom](https://github.com/guyfedwards/nom) - rss reader
- [npm](https://npmjs.com/) - javascript runtime
- [nvim](https://neovim.io/) :star2: - text editor
- [pacman](https://archlinux.org/pacman/) - package manager
- [paru](https://github.com/morganamilo/paru) - aur helper
- [powershell](https://github.com/PowerShell/PowerShell) - shell
- [prettier](https://prettier.io/) - code formatter
- [procs](https://github.com/dalance/procs) - process list
- [python](https://python.org/) - python interpreter
- [qBittorrent](https://www.qbittorrent.org) - torrent client
- [ripgrep](https://github.com/BurntSushi/ripgrep) - grep alternative
- [ruff](https://docs.astral.sh/ruff/) - python linter and formatter
- [sqlite3](https://www.sqlite.org/) - SQL database
- [ssh](https://www.openssh.com/portable.html) - secure shell
- [starship](https://starship.rs/) :star2: - shell prompt
- [streamrip](https://github.com/nathom/streamrip)
- [stylua](https://github.com/JohnnyMorganz/StyLua) - lua formatter
- [systemd](https://www.github.com/systemd/systemd) - system and service manager
- [taplo](https://taplo.tamasfe.dev/) - lsp for toml
- [termux](https://termux.dev/) - terminal emulator
- [tmux](https://tmux.github.io/) :star2: - terminal multiplexer
- [vim](https://www.vim.org) - text editor
- [waybar](https://github.com/Alexays/Waybar) - status bar
- [wofi](https://hg.sr.ht/~scoopta/wofi) - launcher
- [xdg-desktop-portal-termfilechooser](https://github.com/boydaihungst/xdg-desktop-portal-termfilechooser) - xdg-desktop-portal backend for terminal file manager
- [yay](https://github.com/Jguer/yay) - aur helper
- [yazi](https://yazi-rs.github.io/) :star2: - terminal file manager
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - video downloader
- [zathura](https://pwmt.org/projects/zathura/) - document viewer
- [zellij](https://zellij.dev/) - terminal workspace

# setup commands

- termux :star2:

```sh
yes | termux-setup-storage
curl -#LOq -- github.com/AminurAlam/dotfiles/raw/main/setup/termux.sh
```

- arch :star2:

```sh
curl -#LOq -- github.com/AminurAlam/dotfiles/raw/main/setup/arch.sh
```

- debian/ubuntu

```sh
curl -#LOq -- github.com/AminurAlam/dotfiles/raw/main/setup/ubuntu.sh
```

- windows

```ps1
irm "https://github.com/AminurAlam/dotfiles/raw/main/setup/windows.ps1" -OutFile windows.ps1
iex windows.ps1
```
