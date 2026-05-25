function kt -d "cut columns with simple syntax"
    set delim " "
    if not string match -rq -- '\d' $argv[1]
        set delim $argv[1]
        set argv $argv[2..]
    end

    # TODO: try sed 's/([^$delim]+)/\\cols/g'
    # TODO: split on multiple delimins

    # https://github.com/fish-shell/fish-shell/issues/3339
    set cols \$(string join ',$' $argv)

    awk -F "$delim" "{print $cols}"

    if false
        # tests
        test (echo "1 2 3 4" | kt   4 2) = "4 2"
        test (echo "1,2,3,4" | kt   4 2) = ""
        test (echo "1,2,3,4" | kt   1  ) = "1,2,3,4"
        test (echo "1,2,3,4" | kt   1 2) = "1,2,3,4"
        test (echo "1,2,3,4" | kt , 4 2) = "4 2"
    end
end
