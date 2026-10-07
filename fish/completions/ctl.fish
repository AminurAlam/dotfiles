# subcommands
for sub in (rg --replace '$1 $2' '^    case (\w+) # .*  (.*)' (command -v ctl))
    set sub_ad (string split -m 1 -- ' ' "$sub")
    complete -c ctl -n "__fish_is_nth_token 1" -fka "$sub_ad[1]" -d "$sub_ad[2]"
end

complete -c ctl -n "__fish_is_nth_token 2; and __fish_seen_subcommand_from vol lum" -fka '+ -'
complete -c ctl -n "__fish_is_nth_token 2; and __fish_seen_subcommand_from send" -fka '(__fish_print_hostnames)'
complete -c ctl -n "__fish_is_nth_token 2; and __fish_seen_subcommand_from ss" -fka 'full ocr'
