def round2:.*pow(10;2)|round/pow(10;2);

def fs:
    if . == null then
        "-"
    elif . > (1024*1024*1024) then
        (. / (1024*1024*1024) | round2 | tostring) + "G"
    elif . > (1024*1024) then
        (. / (1024*1024)      | floor  | tostring) + "M"
    else
        (. / (1024)           | floor  | tostring) + "K"
    end;

def br:
    if . == null then
        "-"
    elif . > (1024) then
        (./1024 | round2 | tostring) + "M"
    else
        (.      | floor  | tostring) + "K"
    end;

.formats[]
| select(.vcodec != "none")
# | select([.vbr, .tbr] | any)
| select(.format_id | startswith("sb") | not)
| [
    .format_id,
    if .format_note == null then
        .resolution
    else
        if .format_note | startswith("1440p") then
            "2k"
        elif .format_note | startswith("2160p") then
            "4k"
        else
            .format_note
        end
    end,
    (if .filesize then .filesize else .filesize_approx end | fs),
    (if .vbr then .vbr else .tbr end | br)
] | @tsv
