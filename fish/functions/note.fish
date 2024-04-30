function note -a file
    if set -q file && [ -e "/sdcard/main/notes/$file.note" ]
        $EDITOR "$file.note"
    else if set -q file && [ (count (fd "$file"  "/sdcard/main/notes/")) -gt 0 ]
        $EDITOR (fd "$file"  "/sdcard/main/notes/")
    else
        cd "/sdcard/main/notes/"
        $EDITOR +'Telescope find_files'
    end
end
