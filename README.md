# configs found here

- [alacritty](https://alacritty.org/) - terminal emulator
- [anki](https://apps.ankiweb.net/) - flashcards
- [aria2](https://aria2.github.io/) - download manager
- [btop](https://github.com/aristocratos/btop) - system resource monitor
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html) - c formatter
- [clangd](https://clang.llvm.org/) - c++ lsp server
- [curl](https://curl.se/) - request url
- [dunst](https://dunst-project.org/) - notification daemon
- [eza](https://github.com/eza-community/eza) - replacement for ls
  - [dircolors](https://www.gnu.org/software/coreutils/dircolors) - $LS_COLORS generator
- [fish](https://fishshell.com/) :star2: - shell
- [fuzzel](https://codeberg.org/dnkl/fuzzel) - application launcher
- [gallery-dl](https://github.com/mikf/gallery-dl) - program to download image-galleries
- [fzf](https://junegunn.github.io/fzf/) - fuzzy finder
- [gdb](https://www.gnu.org/software/gdb/) - GNU Project debugger
- [git](https://git-scm.com/) - vcs
  - [delta](https://dandavison.github.io/delta/) - git diff pager
  - [lazygit](https://github.com/jesseduffield/lazygit) - ui for git
- [htop](https://htop.dev/) - process viewer
- [hyprland](https://hyprland.org/) - wayland compositor
  - [waybar](https://github.com/Alexays/Waybar) - status bar
  - [wofi](https://hg.sr.ht/~scoopta/wofi) - launcher
- [keepassxc](https://keepassxc.org/) - password manager
- [mgba](http://mgba.io) - GBA emulator
- [mpv](https://mpv.io) - media player
- [newsboat](https://newsboat.org/) :star2: - rss reader
- [npm](https://npmjs.com/) - javascript runtime
- [nvim](https://neovim.io/) :star2: - text editor
  - [vim](https://www.vim.org) - text editor
- [pacman](https://archlinux.org/pacman/) - package manager
- [prettier](https://prettier.io/) - code formatter
- [procs](https://github.com/dalance/procs) - process list
- [python](https://python.org/) - python interpreter
- [ripgrep](https://github.com/BurntSushi/ripgrep) - grep alternative
- [ruff](https://docs.astral.sh/ruff/) - python linter and formatter
- [sqlite3](https://www.sqlite.org/) - SQL database
- [ssh](https://www.openssh.com/portable.html) - secure shell
- [starship](https://starship.rs/) :star2: - shell prompt
- [streamrip](https://github.com/nathom/streamrip)
- [stylua](https://github.com/JohnnyMorganz/StyLua) - lua formatter
- [taplo](https://taplo.tamasfe.dev/) - lsp for toml
- [termux](https://termux.dev/) - terminal emulator
- [tmux](https://tmux.github.io/) :star2: - terminal multiplexer
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
Invoke-Expression $((Invoke-WebRequest https://github.com/AminurAlam/dotfiles/raw/main/setup/windows.ps1).Content)
```
