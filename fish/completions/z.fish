function __zoxide_z_complete
    set -l token (commandline -t)

    # PATH
    # complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*'
    complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    complete --do-complete "'' ."(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$' | string match -v --regex '^\.\.?/$'

    # ZOXIDE
    [ -n "$token" ] && zoxide query --exclude (pwd -L) -l -- "$token" | string replace "$HOME" '~'
end
complete --command z --no-files --arguments '(__zoxide_z_complete)'
