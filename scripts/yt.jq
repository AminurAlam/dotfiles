def round2:.*pow(10;2)|round/pow(10;2);

def fs: 
    if . > (1024*1024*1024) then
        (. / (1024*1024*1024) | round2 | tostring) + "G"
    elif . > (1024*1024) then
        (. / (1024*1024)      | floor  | tostring) + "M"
    else
        (. / (1024)           | floor  | tostring) + "K"
    end;

def br:
    if . > (1024) then
        (./1024 | round2 | tostring) + "M"
    else
        (.      | floor  | tostring) + "K"
    end;

if (.extractor == "youtube") then
    .formats[]
    | select(.vcodec != "none")
    | select(.vbr)
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
        (.filesize | fs),
        (.vbr | br)
    ] | @tsv
else
    .formats[]
    | [
        .format_id,
        ([.format_note, .resolution] | unique | join(", ")),
        (.filesize | fs),
        (.vbr | br)
    ] | @tsv
end
