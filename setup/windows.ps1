winget install Neovim.Neovim Neovide.Neovide Git.Git Mozilla.Firefox astral-sh.ruff
winget upgrade Neovim.Neovim

cd ~
git clone --depth 1 "https://github.com/AminurAlam/dotfiles"
Copy-item -Force -Recurse -Verbose .\dotfiles\nvim\ -Destination .\AppData\Local\

python -m pip install pyright python-language-server

nvim
