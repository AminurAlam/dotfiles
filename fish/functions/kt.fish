function kt -d "cut columns with simple syntax"
    set delim " "
    if not string match -rq -- '\d' $argv[1]
        set delim $argv[1]
        set argv $argv[2..]
    end

    # TODO: try sed 's/([^$delim]+)/\\cols/g'

    # https://github.com/fish-shell/fish-shell/issues/3339
    set cols \$(string join ',$' $argv)

    awk -F "$delim" "{print $cols}"
end
