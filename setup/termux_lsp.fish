set -q XDG_PROJECTS_DIR || set XDG_PROJECTS_DIR "$HOME/repos"
set patches "$XDG_PROJECTS_DIR/dotfiles/scripts/patches"

# npm i -g bash-language-server
pacman -Syu --noconfirm --needed clang rust-analyzer lua-language-server

function python_lsp
    cd "$XDG_PROJECTS_DIR"
    pacman -Syu --noconfirm --needed ruff python-pip

    git clone -q --depth 1 "https://github.com/astral-sh/ruff-lsp"
    patch ruff-lsp/pyproject.toml <"$patches/ruff-lsp-pyproject.toml.diff"

    pip install ./ruff-lsp pyright python-lsp-server

    yes | rm -rf ruff-lsp
end

function java_lsp
    cd "$XDG_PROJECTS_DIR"
    pacman -Syu --noconfirm --needed openjdk-17 maven

    git clone -q --depth 1 "https://github.com/georgewfraser/java-language-server"
    patch java-language-server/pom.xml <"$patches/java-language-server-pom.xml.diff"

    ./java-language-server/scripts/link_linux.sh
    mvn package -DskipTests -Dmaven.javadoc.skip

    # yes | rm -rf java-language-server
end
