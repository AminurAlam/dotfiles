function style
    command -vq stylua || pacman -S stylua
    for file in $XDG_CONFIG_HOME/nvim/**.lua
        stylua --no-editorconfig -caf "$XDG_CONFIG_HOME/stylua.toml" "$file" && continue
        [ "$(read -P 'apply the changes? [y/N] ')" = y ]
        and stylua --no-editorconfig -af "$XDG_CONFIG_HOME/stylua.toml" "$file"
    end
end
