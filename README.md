# configs found here

- [alacritty](https://alacritty.org/) - terminal emulator
- [anki](https://apps.ankiweb.net/) - flashcards
- [aria2](https://aria2.github.io/) - download manager
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html) - c formatter
- [clangd](https://clang.llvm.org/) - c++ lsp server
- [curl](https://curl.se/) - request url
- [eza](https://github.com/eza-community/eza) - replacement for ls
  - [dircolors](https://www.gnu.org/software/coreutils/dircolors) - $LS_COLORS generator
- [fish](https://fishshell.com/) :star2: - shell
- [fzf](https://junegunn.github.io/fzf/) - fuzzy finder
- [gdb](https://www.gnu.org/software/gdb/) - GNU Project debugge
- [git](https://git-scm.com/) - vcs
  - [delta](https://dandavison.github.io/delta/) - git diff pager
- [htop](https://htop.dev/) - process viewer
- [lazygit](https://github.com/jesseduffield/lazygit) - ui for git
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
- [starship](https://starship.rs/) :star2: - shell prompt
- [streamrip](https://github.com/nathom/streamrip)
- [stylua](https://github.com/JohnnyMorganz/StyLua) - lua formatter
- [taplo](https://taplo.tamasfe.dev/) - lsp for toml
- [termux](https://termux.dev/) - terminal emulator
- [tmux](https://tmux.github.io/) :star2: - terminal multiplexer
- [yazi](https://yazi-rs.github.io/) :star2: - terminal file manager
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - video downloader
- [zellij](https://zellij.dev/) - terminal workspace

<!-- l --no-filesize | awk -F ' ' '{print "  <li>" $0 "</li>"}' -->
<details>
<summary>nvim plugins</summary>
<ul>
    <li>alpha-nvim</li>
    <li>cmp-buffer</li>
    <li>cmp-cmdline</li>
    <li>cmp-fish</li>
    <li>cmp-nvim-lsp</li>
    <li>cmp-nvim-lua</li>
    <li>cmp-path</li>
    <li>cmp_luasnip</li>
    <li>csvview.nvim</li>
    <li>cybu.nvim</li>
    <li>dial.nvim</li>
    <li>diffview.nvim</li>
    <li>dressing.nvim</li>
    <li>friendly-snippets</li>
    <li>full_visual_line.nvim</li>
    <li>git-dev.nvim</li>
    <li>gitsigns.nvim</li>
    <li>highlight-undo.nvim</li>
    <li>indent-blankline.nvim</li>
    <li>lazy.nvim</li>
    <li>LuaSnip</li>
    <li>mason.nvim</li>
    <li>mini.bracketed</li>
    <li>none-ls.nvim</li>
    <li>nvim-cmp</li>
    <li>nvim-colorizer.lua</li>
    <li>nvim-surround</li>
    <li>nvim-treesitter</li>
    <li>nvim-web-devicons</li>
    <li>plenary.nvim</li>
    <li>tardis.nvim</li>
    <li>telescope.nvim</li>
    <li>todo-comments.nvim</li>
    <li>tokyonight.nvim</li>
    <li>treesj</li>
    <li>trouble.nvim</li>
    <li>ultimate-autopair.nvim</li>
</ul>
</details>

# setup commands

- termux

```sh
yes | termux-setup-storage
curl -#Lq -o termux.sh -- github.com/AminurAlam/dotfiles/raw/main/setup/termux.sh
bash termux.sh
```

- ubuntu

```sh
curl -#Lq github.com/AminurAlam/dotfiles/raw/main/setup/ubuntu.sh | sudo bash
```

- windows

```ps1
Invoke-Expression $((Invoke-WebRequest https://github.com/AminurAlam/dotfiles/raw/main/setup/windows.ps1).Content)
```
