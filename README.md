## configs found here

- [aria2](https://aria2.github.io/) - download manager
- [anki](https://apps.ankiweb.net/) - flashcards
- [clangd](https://clang.llvm.org/) - c++ lsp server
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html) - c formatter
- [curl](https://curl.se/) - request url
- [eza](https://github.com/eza-community/eza) - replacement for ls
- [fish](https://fishshell.com/) - shell
- [fzf](https://junegunn.github.io/fzf/) - fuzzy finder
- [git](https://git-scm.com/) - vcs
- [htop](https://htop.dev/) - process viewer
- [newsboat](https://newsboat.org/) - rss reader
- [npm](https://npmjs.com/) - javascript runtime
- [nvim](https://neovim.io/) - text editor
- [pacman](https://archlinux.org/pacman/) - package manager
- [procs](https://github.com/dalance/procs) - replacement for ps
- [python](https://python.org/) - python interpreter
- [ripgrep](https://github.com/BurntSushi/ripgrep) - grep alternative
- [ruff](https://docs.astral.sh/ruff/) - python linter and formatter
- [starship](https://starship.rs/) - shell prompt
- [streamrip](https://github.com/nathom/streamrip)
- [stylua](https://github.com/JohnnyMorganz/StyLua) - lua formatter
- [termux](https://termux.dev/) - terminal emulator
- [tmux](https://tmux.github.io/) - terminal multiplexer
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - video downloader
- [zellij](https://zellij.dev/) - terminal workspace

## setup commands

- termux

```sh
yes | termux-setup-storage
curl -q#Lo termux.sh -- https://github.com/AminurAlam/dotfiles/raw/main/setup/termux.sh
bash termux.sh
```

- ubuntu

```sh
curl https://github.com/AminurAlam/dotfiles/raw/main/setup/ubuntu.sh | bash
```

- windows

```powershell
Invoke-Expression $((Invoke-WebRequest https://github.com/AminurAlam/dotfiles/raw/main/setup/windows.ps1).Content)
```
