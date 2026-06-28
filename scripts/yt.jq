if (.extractor == "youtube") then
    .formats[]
    | select(.vcodec != "none")
    | select(.vbr)
    | select(.format_id | startswith("sb") | not)
    | [
        .format_id,
        .resolution,
        (.filesize / (1024*1024) | floor | tostring) + "M",
        (.vbr | floor | tostring) + "K"
    ] | @tsv
else
    .formats[]
    | [
        .format_id,
        ([.format_note, .resolution] | unique | join(", ")),
        (.filesize / (1048576) | floor | tostring) + "M",
        (.vbr | floor | tostring) + "K"
    ] | @tsv
end
