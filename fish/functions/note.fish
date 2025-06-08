function note -a file -d "notes manager"
    if [ -n "$file" ]
        [ -f "$file" ]
        and $EDITOR "$file"
        or $EDITOR "$XDG_PROJECTS_DIR/notes/$file.note"
    else
        cd $XDG_PROJECTS_DIR/notes/
        $EDITOR +"lua require 'telescope.builtin'.find_files()"
    end
end
