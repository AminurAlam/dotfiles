function note -a file -d "notes manager"
    if [ -n "$file" ]
        $EDITOR "$XDG_DOCUMENTS_DIR/$file.note"
        return 0
    else
        cd $XDG_DOCUMENTS_DIR
        $EDITOR +"lua require 'telescope.builtin'.find_files()"
    end
end
