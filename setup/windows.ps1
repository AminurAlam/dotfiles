winget install neovim neovide Git.git mozilla.firefox astral-sh.ruff

cd ~
git clone --depth 1 "https://github.com/AminurAlam/dotfiles"
Copy-item -Force -Recurse -Verbose .\dotfiles\nvim\ -Destination .\AppData\Local\

pip install pyright python-language-server

nvim
