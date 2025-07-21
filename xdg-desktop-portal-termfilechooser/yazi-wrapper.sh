#!/usr/bin/env bash

set -x

# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.
#
# Inputs:
# 1. "1" if multiple files can be chosen, "0" otherwise.
# 2. "1" if a directory should be chosen, "0" otherwise.
# 3. "0" if opening files was requested, "1" if writing to a file was
#    requested. For example, when uploading files in Firefox, this will be "0".
#    When saving a web page in Firefox, this will be "1".
# 4. If writing to a file, this is recommended path provided by the caller. For
#    example, when saving a web page in Firefox, this will be the recommended
#    path Firefox provided, such as "~/Downloads/webpage_title.html".
#    Note that if the path already exists, we keep appending "_" to it until we
#    get a path that does not exist.
# 5. The output path, to which results should be written.
#
# Output:
# The script should print the selected paths to the output path (argument #5),
# one path per line.
# If nothing is printed, then the operation is assumed to have been canceled.

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"
if [ "$save" = "1" ]; then
    TITLE="Save File:"
elif [ "$directory" = "1" ]; then
    TITLE="Select Directory:"
else
    TITLE="Select File:"
fi

quote_string() {
    local input="$1"
    echo "'${input//\'/\'\\\'\'}'"
}

cleanup() {
    if [ -f "$tmpfile" ]; then
        /usr/bin/rm "$tmpfile" || :
    fi
    if [ "$save" = "1" ] && [ ! -s "$out" ]; then
        /usr/bin/rm "$path" || :
    fi
}

trap cleanup EXIT HUP INT QUIT ABRT TERM

if [ "$save" = "1" ]; then
    tmpfile=$(/usr/bin/mktemp)

    # Save/download file
    /usr/bin/printf '%s' '=== xdg-desktop-portal-termfilechooser file ===' >"$path"
    set -- --chooser-file="$(quote_string "$tmpfile")" "$(quote_string "$path")"
elif [ "$directory" = "1" ]; then
    # upload files from a directory
    # Use this if you want to select folder by 'quit' function in yazi.
    set -- --cwd-file="$(quote_string "$out")" "$(quote_string "$path")"
    # NOTE: Use this if you want to select folder by enter a.k.a yazi keybind for 'open' funtion ('run = "open") .
    # set -- --chooser-file="$out" "$path"
elif [ "$multiple" = "1" ]; then # upload multiple files
    set -- --chooser-file="$(quote_string "$out")" "$(quote_string "$path")"
else # upload only 1 file
    set -- --chooser-file="$(quote_string "$out")" "$(quote_string "$path")"
fi

eval "/usr/bin/alacritty --title $(quote_string "$TITLE") -e /usr/bin/yazi $@"

# case save file
if [ "$save" = "1" ] && [ -s "$tmpfile" ]; then
    selected_file=$(/usr/bin/head -n 1 "$tmpfile")
    # Check if selected file is placeholder file
    if [ -f "$selected_file" ] && /usr/bin/grep -qi "^=== xdg-desktop-portal-termfilechooser file ===$" "$selected_file"; then
        /usr/bin/echo "$selected_file" >"$out"
        path="$selected_file"
    fi
fi
