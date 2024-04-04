function note -a file

    if [ -n "$file" -a -e "/sdcard/main/notes/$file.note" ]
        $EDITOR "$file.note"
    else if [ -n "$file" -a (count (fd "$file"  "/sdcard/main/notes/")) -gt 0 ]
        $EDITOR (fd "$file"  "/sdcard/main/notes/")
    else
        cd "/sdcard/main/notes/"
        $EDITOR +'Telescope find_files'
    end
end
