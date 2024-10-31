set patches "$XDG_PROJECTS_DIR/dotfiles/scripts/patches"

pacman -Syu --noconfirm --needed ruff clang rust-analyzer lua-language-server

function python_lsp
    pacman -Syu --noconfirm --needed python nodejs python-pip
    pip install pyright
end

function java_lsp
    cd "$XDG_PROJECTS_DIR"
    pacman -Syu --noconfirm --needed openjdk-17 maven

    git clone -q --depth 1 "https://github.com/georgewfraser/java-language-server"
    patch java-language-server/pom.xml <$patches/java-language-server-pom.xml.diff

    ./java-language-server/scripts/link_linux.sh
    mvn package -DskipTests -Dmaven.javadoc.skip
    and pacman -Rs maven
end

function npm_based_lsp
    pacman -S --noconfirm --needed nodejs
    npm i -g bash-language-server prettier
    termux-fix-shebang $HOME/.local/share/npm/bin/*
end

if not [ -d "$patches" ]
    echo "$patches is not a directory!"
    echo "make sure variables are properly set"
end

echo "available functions: python_lsp, java_lsp, npm_based_lsp"
