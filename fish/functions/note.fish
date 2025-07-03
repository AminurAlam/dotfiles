function note -a file -d "notes manager"
    if [ -n "$file" ]
        [ -f "$file" ]
        and $EDITOR "$file"
        or $EDITOR "$HOME/repos/notes/$file.note"
    else
        cd $HOME/repos/notes/
        $EDITOR +"lua require 'telescope.builtin'.find_files()"
    end
end
