![file manager and terminal](https://github.com/user-attachments/assets/007e3799-90a0-4feb-844c-6b2696ac3832 "file manager and terminal")
![lazygit and nvim](https://github.com/user-attachments/assets/63077fbf-21ee-4ab5-a2c9-bf441272ece8 "file manager and terminal")

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
- [foot](https://codeberg.org/dnkl/foot) :star2: - Fast, lightweight, and minimalistic Wayland terminal emulator
- [fuzzel](https://codeberg.org/dnkl/fuzzel) - application launcher
- [fzf](https://junegunn.github.io/fzf/) - fuzzy finder
- [gallery-dl](https://github.com/mikf/gallery-dl) - program to download image-galleries
- [gdb](https://www.gnu.org/software/gdb/) - GNU Project debugger
- [ghostty](https://github.com/ghostty-org/ghostty) - terminal emulator
- [git](https://git-scm.com/) - vcs
- [glow](https://github.com/charmbracelet/glow) - Command-line markdown renderer
- [helix](https://helix-editor.com) - A post-modern modal text editor
- [htop](https://htop.dev/) - process viewer
- [hyprland](https://hyprland.org/) - tiling wayland compositor
- [jujustu](https://github.com/jj-vcs/jj) - vcs
- [kanata](https://github.com/jtroo/kanata) :star2: - keyboard customizer
- [keepassxc](https://keepassxc.org/) - password manager
- [kitty](https://github.com/kovidgoyal/kitty) - terminal emulator
- [lazygit](https://github.com/jesseduffield/lazygit) - ui for git
- [librewolf](https://librewolf.net/) :star2: - Community-maintained fork of Firefox, focused on privacy, security and freedom
- [ly](https://codeberg.org/fairyglade/ly) - TUI display manager
- [mgba](http://mgba.io) - GBA emulator
- [mpv](https://mpv.io) - media player
- [newsboat](https://newsboat.org/) - rss reader
- [newsraft](https://codeberg.org/newsraft/newsraft) - feed reader for terminal
- [niri](https://github.com/YaLTeR/niri) :star2: - scrollable-tiling wayland compositor
- [npm](https://npmjs.com/) - javascript runtime
- [nvim](https://neovim.io/) :star2: - text editor
- [pacman](https://archlinux.org/pacman/) - package manager
- [paru](https://github.com/morganamilo/paru) - aur helper
- [powershell](https://github.com/PowerShell/PowerShell) - windows shell
- [prettier](https://prettier.io/) - code formatter
- [procs](https://github.com/dalance/procs) - process list
- [python](https://python.org/) - python interpreter
- [qalculate](https://qalculate.github.io/) - Multi-purpose desktop calculator
- [qBittorrent](https://www.qbittorrent.org) - torrent client
- [ripgrep](https://github.com/BurntSushi/ripgrep) - grep alternative
- [ruff](https://docs.astral.sh/ruff/) - python linter and formatter
- [sqlite3](https://www.sqlite.org/) - SQL database
- [ssh](https://www.openssh.com/portable.html) :star2: - secure shell
- [starship](https://starship.rs/) :star2: - shell prompt
- [streamrip](https://github.com/nathom/streamrip) - A scriptable stream downloader for Qobuz, Tidal, Deezer and SoundCloud
- [stylua](https://github.com/JohnnyMorganz/StyLua) - code formatter for Lua
- [swayimg](https://github.com/artemsen/swayimg) - image viewer
- [systemd](https://www.github.com/systemd/systemd) - system and service manager
- [taplo](https://taplo.tamasfe.dev/) - lsp for toml
- [termux](https://termux.dev/) :star2: - terminal emulator
- [tmux](https://tmux.github.io/) - terminal multiplexer
- [tombi](https://tombi-toml.github.io/tombi/) - TOML Formatter / Linter / Language Server
- [vim](https://www.vim.org) - text editor
- [waybar](https://github.com/Alexays/Waybar) - status bar
- [wofi](https://hg.sr.ht/~scoopta/wofi) - launcher
- [xdg-desktop-portal-termfilechooser](https://github.com/boydaihungst/xdg-desktop-portal-termfilechooser) - xdg-desktop-portal backend for terminal file manager
- [xdg-desktop-portal](https://flatpak.github.io/xdg-desktop-portal/) - for desktop stuff
- [yay](https://github.com/Jguer/yay) - aur helper
- [yazi](https://yazi-rs.github.io/) :star2: - terminal file manager
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - video downloader
- [zathura](https://pwmt.org/projects/zathura/) - document viewer
- [zellij](https://zellij.dev/) - terminal workspace
- [zoxide](https://github.com/ajeetdsouza/zoxide) - A smarter cd command for your terminal

a more complete list of packages can be found in [setup/arch.pkglist](setup/arch.pkglist)

# setup commands

termux :star2:

```sh
yes | termux-setup-storage
curl -#LOq -- github.com/AminurAlam/dotfiles/raw/main/setup/termux.sh
```

arch :star2:

```sh
curl -#LOq -- github.com/AminurAlam/dotfiles/raw/main/setup/arch.sh
```

ubuntu

```sh
curl -#LOq -- github.com/AminurAlam/dotfiles/raw/main/setup/ubuntu.sh
```

windows

```ps1
irm "https://github.com/AminurAlam/dotfiles/raw/main/setup/windows.ps1" -OutFile windows.ps1
```

# mirrors

[codeberg](https://codeberg.org/AminurAlam/dotfiles)

```sh
git clone https://codeberg.org/AminurAlam/dotfiles.git
```

[gitlab](https://gitlab.com/AminurAlam/dotfiles)

```sh
git clone https://gitlab.com/AminurAlam/dotfiles.git
```

[github](https://github.com/AminurAlam/dotfiles)

```sh
git clone https://github.com/AminurAlam/dotfiles.git
```
