function lg -d "lazygit wrapper to change directories"
    set -gx LAZYGIT_NEW_DIR_FILE (mktemp -t "lazygit-cwd.XXXXXX")
    [ (uname -o) = Android ] && set arg status
    TERM=xterm-256color lazygit $arg # TODO: file bug in treesitter parser

    if set cwd (command cat -- "$LAZYGIT_NEW_DIR_FILE")
        and [ -n "$cwd" ]
        and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$LAZYGIT_NEW_DIR_FILE"
end
