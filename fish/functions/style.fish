function style
    for file in $XDG_CONFIG_HOME/**.lua
        stylua -cf "$XDG_CONFIG_HOME/nvim/stylua.toml" "$file" && continue
        read choice -fP "apply the changes? [Y/n] "
        if [ -z $choice -o $choice = y ]
            stylua -f "$HOME/.config/nvim/stylua.toml" "$file"
        end
    end
end
