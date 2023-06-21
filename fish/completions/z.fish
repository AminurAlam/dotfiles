# make zoxide completions actually useful
function __better_z_complete
    set -l token (commandline -t)
    [ -n "$token" ] && zoxide query --exclude "$(pwd -L)" -l -- "$token" | string replace "$HOME" '~'
end

complete --command __zoxide_z -fka '(__better_z_complete)/'
