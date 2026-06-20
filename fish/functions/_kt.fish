function kt -d "cut columns with simple syntax"
    set delim " "
    if not string match -rq -- '\d' $argv[1]
        set delim $argv[1]
        set argv $argv[2..]
    end

    # TODO: try sed 's/([^$delim]+)/\\cols/g'
    # TODO: try string split -f (string join ',' $argv) $delim
    # TODO: split on multiple delimins

    # https://github.com/fish-shell/fish-shell/issues/3339
    set cols \$(string join ',$' $argv | sed -E 's/\$([^0-9,]+),/"\1",/g')
    # printf '%s\n' $cols

    awk -F "$delim" "{print $cols}"

    # TESTS
    if false
        test (echo "a b c d" | kt 1 3) = "a c"

        # position
        test (echo "a b c d" | kt 4 2) = "d b"

        # delim
        test (echo "a,b,c,d" | kt   1 3) = "a,b,c,d "
        test (echo "a,b,c,d" | kt   2 4) = " "
        test (echo "a,b,c,d" | kt , 4 2) = "d b"
        test (echo "a b,c d" | kt , 2 ) = "c d"

        # insertion
        test (echo "a,b,c,d" | kt , 4 hello 2) = "d hello b"
        test (echo "a b c d" | kt   1 hi 2 hello 3 4) = "a hi b hello c d"
        test (echo "a b c d" | kt   1 hi bye 2) = 'a hi bye b'

        # nil
        test (echo "a,b,c,d" | kt   1 2) = "a,b,c,d "
    end
end
