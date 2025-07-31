function note -a file -d "notes manager"
    builtin cd "$HOME/repos/notes/"

    if [ -n "$file" ]
        [ -f "$file" ]
        and $EDITOR "$file"
        or $EDITOR "$file.note"
    else
        $EDITOR +"Telescope find_files"
    end
end
