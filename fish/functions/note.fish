function note -a file
    if [ -n "$file" ]
        $EDITOR "/sdcard/main/notes/$file.note"
        return 0
    end
    cd /sdcard/main/notes/
    $EDITOR +"lua require 'telescope.builtin'.find_files()"
end
