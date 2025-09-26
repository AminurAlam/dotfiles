function note -a file -d "notes manager"
    builtin cd "$HOME/repos/notes/"

    if [ -n "$file" ]
        [ -f "$file" ]
        and $EDITOR "$file"
        or $EDITOR "$file.md"
    else
        $EDITOR +"Telescope find_files"
    end
end
