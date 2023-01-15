function style
    set -f dirs $XDG_CONFIG_HOME/nvim/init.lua $XDG_CONFIG_HOME/nvim/lua/*/*.lua
    stylua -cf "$XDG_CONFIG_HOME/nvim/stylua.toml" $dirs
    read choice -fP "apply the changes? [Y/n] "
    if test -z $choice -o $choice = y
        stylua -f "$HOME/.config/nvim/stylua.toml" $dirs
    end
end
