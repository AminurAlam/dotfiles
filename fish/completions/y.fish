function __path_complete
    complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*'
    complete --do-complete "'' ."(builtin commandline --cut-at-cursor --current-token) | string match -v --regex '^\.\.?/$'
end

function __zoxide_complete
    set -l token (commandline -t)
    command -vq zoxide || return
    set -q token && zoxide query --exclude (pwd -L) -l -- "$token" | string replace "$HOME" '~'
end

complete y -a '(__path_complete)'
complete y -a '(__zoxide_complete)/'
