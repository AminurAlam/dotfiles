def fs:
    . | tonumber |
    if . == 0 then
        "0"
    elif . > (1024*1024*1024) then
        (100 * . / (1024*1024*1024) | round/100 | tostring) + "G"
    elif . > (1024*1024) then
        (. / (1024*1024)      | floor  | tostring) + "M"
    else
        (. / (1024)           | floor  | tostring) + "K"
    end
;

def pad(str; count):
    if (str | length) > count then
        str
    else
    " " * (count - (str|length)) + str
    end
;

def fs_percent(comp; total; all):
    if (comp == total) then
        pad((total | fs) + " \u001b[38;5;2m100%\u001b[0m"; 23)
    else
            pad(if all then total else comp end | fs; 6)
            + " "
            + pad(100 * (comp | tonumber) / (total | tonumber) | round | tostring; 3)
            + "%"
    end
;

def eta(comp; total; speed):
    if comp == total then
        ""
    elif speed == "0" then
        "  "
    else
        ((total|tonumber) - (comp|tonumber))
        / (speed|tonumber)
        | round 
        | strftime("%H:%M:%S")
    end
;

.result |
("[" + .status + "] " + (.dir | gsub("^/home/fisher"; "~")) + "/" + .bittorrent.info.name),
("DL: "
    + pad(.downloadSpeed | fs; 5) + "B/s "
    + fs_percent(.completedLength; .totalLength; true) + " "
    + eta(.completedLength; .totalLength; .downloadSpeed)),
("UP: "
    + pad(.uploadSpeed | fs; 5) + "B/s "
    + pad(.uploadLength | fs; 5) + " "),
(.dir | length) as $dlen | "=" * 80,
(
    .files[]
    | select(.selected == "true")
    | fs_percent(.completedLength; .length; false)
    + " \u001b[38;5;4m" + pad(.index; 2) + "\u001b[0m " + .path[$dlen+1:$dlen+92]
),
(
    .files[]
    | select(.selected == "false")
    | fs_percent(.completedLength; .length; false)
    + " \u001b[38;5;1m" + pad(.index; 2) + "\u001b[0m " + .path[$dlen+1:$dlen+92]
),
(if .errorMessage then .errorMessage else "" end),
"press `q` to exit"
