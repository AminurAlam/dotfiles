# make zoxide completions actually useful
function __better_y_complete
    set -l token (commandline -t)
    set -q token && zoxide query --exclude (pwd -L) -l -- "$token" | string replace "$HOME" '~'
end

function __zoxide_y_complete
    complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
end

# complete --command y -fka '(__better_y_complete)/'
# complete --command y -fka '(__fish_complete_cd)'

complete -k --no-files y -a '(__better_y_complete)/'
complete --no-files y -a '(__zoxide_y_complete)'
