function kt -d "cut columns with simple syntax"
    set delim " "
    if not string match -rq -- '\d' $argv[1]
        set delim $argv[1]
        set argv $argv[2..]
    end

    set cols \$(string join ',$' $argv)

    awk -F "$delim" "{print $cols}"
end
