def round2:.*pow(10;2)|round/pow(10;2);

def fs:
    if . == null then
        "-"
    else
    . | tonumber |
        if . > (1024*1024*1024) then
            (. / (1024*1024*1024) | round2 | tostring) + "G"
        elif . > (1024*1024) then
            (. / (1024*1024)      | floor  | tostring) + "M"
        else
            (. / (1024)           | floor  | tostring) + "K"
        end
    end;

def pad(str; count):
    if (str | length) > count then
        str
    else
    " " * (count - (str|length)) + str
    end
;

def fs_percent:
    if (.[0] == .[1]) then
        "100%"
    else
        pad(
            (.[0] | fs)
            + "/"
            + (.[1] | fs)
            + " "
            + (10000 * (.[0] | tonumber) / (.[1] | tonumber) | round / 100 | tostring)
            + "%"
            ; 16
        )
    end
;

# TODO: ETA

.result |
("[" + .status + "] " + .dir + "/" + .bittorrent.info.name),
("DL: " + ([.completedLength, .totalLength] | fs_percent) + " " + (.downloadSpeed | fs)),
("UP: " + (.uploadLength | fs) + " " + (.uploadSpeed | fs)),
("CN: " + .connections + "  SD: " + .numSeeders),
(.dir | length) as $dlen | "=" * 80,
(
    .files[]
    | select(.selected == "true")
    | ([.completedLength, .length] | fs_percent)
    + " \u001b[38;5;2m" + pad(.index; 2) + "\u001b[0m " + .path[$dlen+1:]
),
(
    .files[]
    | select(.selected == "false")
    | ([.completedLength, .length] | fs_percent)
    + " \u001b[38;5;1m" + pad(.index; 2) + "\u001b[0m " + .path[$dlen+1:]
),
(if .errorMessage then .errorMessage else "" end),
# (.), # debug
"press `q` to exit"
