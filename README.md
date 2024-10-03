## configs found here

- [anki](https://apps.ankiweb.net/) - flashcards
- [aria2](https://aria2.github.io/) - download manager
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html) - c formatter
- [clangd](https://clang.llvm.org/) - c++ lsp server
- [curl](https://curl.se/) - request url
- [eza](https://github.com/eza-community/eza) - replacement for ls
- :star2: [fish](https://fishshell.com/) - shell
- [fzf](https://junegunn.github.io/fzf/) - fuzzy finder
- [git](https://git-scm.com/) - vcs
- [htop](https://htop.dev/) - process viewer
- :star2: [newsboat](https://newsboat.org/) - rss reader
- [npm](https://npmjs.com/) - javascript runtime
- :star2: [nvim](https://neovim.io/) - text editor
- [nyaa](https://github.com/Beastwick18/nyaa/) - nyaa.si browser
- [pacman](https://archlinux.org/pacman/) - package manager
- [python](https://python.org/) - python interpreter
- [ripgrep](https://github.com/BurntSushi/ripgrep) - grep alternative
- [ruff](https://docs.astral.sh/ruff/) - python linter and formatter
- :star2: [starship](https://starship.rs/) - shell prompt
- [streamrip](https://github.com/nathom/streamrip)
- [stylua](https://github.com/JohnnyMorganz/StyLua) - lua formatter
- [taplo](https://taplo.tamasfe.dev/) - lsp for toml
- [termux](https://termux.dev/) - terminal emulator
- [tmux](https://tmux.github.io/) - terminal multiplexer
- :star2: [yazi](https://yazi-rs.github.io/) - terminal file manager
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - video downloader
- [zellij](https://zellij.dev/) - terminal workspace

## setup commands

- termux

```sh
yes | termux-setup-storage
curl -q#Lo termux.sh -- github.com/AminurAlam/dotfiles/raw/main/setup/termux.sh
bash termux.sh
```

- ubuntu

```sh
curl -q#L github.com/AminurAlam/dotfiles/raw/main/setup/ubuntu.sh | sudo bash
```

- windows

```ps1
Invoke-Expression $((Invoke-WebRequest https://github.com/AminurAlam/dotfiles/raw/main/setup/windows.ps1).Content)
```
