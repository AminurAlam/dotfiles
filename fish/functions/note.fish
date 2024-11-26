function note -a file -d "notes manager"
    if [ -n "$file" ]
        [ -f "$file" ]
        and $EDITOR "$file"
        or $EDITOR "$XDG_DOCUMENTS_DIR/$file.note"
    else
        cd $XDG_DOCUMENTS_DIR
        $EDITOR +"lua require 'telescope.builtin'.find_files()"
    end
end
