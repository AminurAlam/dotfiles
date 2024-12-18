set prerequisites python python-pip openjdk-21 maven nodejs
set pkg_lsp ruff clang rust-analyzer lua-language-server taplo texlab
set npm_lsp basedpyright
set mason_lsp ktlint prettier bash-language-server html-lsp kotlin-language-server java-language-server

set -gx JAVA_HOME $PREFIX/lib/jvm/java-21-openjdk
set -gxp --path PATH "$PREFIX/lib/jvm/java-21-openjdk/bin"

pacman -Syu --noconfirm --needed $pkg_lsp
pacman -Syu --noconfirm --needed $prerequisites

npm install -g $npm_lsp

if command -vq nvim && [ -d ~/.local/share/nvim/lazy/mason.nvim/ ]
    nvim "+MasonInstall $mason_lsp"
else
    printf "nvim/mason not found the following lsp couldnt be installed:\n"
    printf "%s\n" $mason_lsp
end

termux-fix-shebang ~/.local/share/nvim/mason/bin/* ~/.local/share/npm/bin/*
