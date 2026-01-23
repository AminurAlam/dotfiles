#!/usr/bin/fish --no-config

set multiple $argv[1]
set directory $argv[2]
set save $argv[3]
set path $argv[4]
set out $argv[5]

# https://fishshell.com/docs/current/cmds/trap.html
# function cleanup --on-signal EXIT -s HUP -s INT -s QUIT -s ABRT -s TERM
#     notify-send TODO cleanup
#     [ -f "$tmpfile" ]
#     and /usr/bin/rm "$tmpfile"
#     or :
#
#     if [ "$save" = 1 ] && [ ! -s "$out" ]
#         /usr/bin/rm "$path" || :
#     end
# end

if [ "$save" = 1 ]
    set tmpfile (/usr/bin/mktemp)
    /usr/bin/printf '%s' '=== xdg-desktop-portal-termfilechooser file ===' >"$path"
    set args --chooser-file (string escape -- $tmpfile)
else if [ "$directory" = 1 ]
    set args --cwd-file (string escape -- $out)
else
    set args --chooser-file (string escape -- $out)
end

footclient --title file_chooser -e yazi $args -- $path

if [ "$save" = 1 ] && [ -s "$tmpfile" ]
    set selected_file $(/usr/bin/head -n 1 "$tmpfile")

    if [ -f "$selected_file" ] && /usr/bin/grep -qi '^=== xdg-desktop-portal-termfilechooser file ===$' "$selected_file"
        /usr/bin/echo "$selected_file" >"$out"
        set path "$selected_file"
    end
end
