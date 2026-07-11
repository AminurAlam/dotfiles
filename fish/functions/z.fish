function z -d "zoxide function for changing directory" -a query
    if not [ -z "$query" -o -d "$query" ]
        set query (command zoxide query --exclude (builtin pwd -L) -- $query)
    end
    cd $query
end
