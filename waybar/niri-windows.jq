[
    .[]
    | (
        .width/480 | round
        ) * (
        if ([.windows[].is_focused] | any) then
            "█"
        else
            "🮘"
        end
    )
] | join(" ")
