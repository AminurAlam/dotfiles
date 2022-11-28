function fish_logo \
    --description="Fish-shell colorful ASCII-art logo" \
    --argument-names outer_color medium_color inner_color mouth eye

    # defaults:
    [ $outer_color  ]; or set outer_color  'red'
    [ $medium_color ]; or set medium_color 'f70'
    [ $inner_color  ]; or set inner_color  'yellow'
    [ $mouth ]; or set mouth '['
    [ $eye   ]; or set eye   'O'

    set usage 'Usage: fish_logo <outer_color> <medium_color> <inner_color> <mouth> <eye>
See set_color --help for more on available colors.'

    if contains -- $outer_color '--help' '-h' '-help'
        echo $usage
        return 0
    end

    # shortcuts:
    set o (set_color $outer_color)
    set m (set_color $medium_color)
    set i (set_color $inner_color)
    set pad (printf "%.0s " (seq (   math -s 0 \($COLUMNS/2\) - 20  )))

    if test (count $o) != 1; or test (count $m) != 1; or test (count $i) != 1
        echo 'Invalid color argument'
        echo $usage
        return 1
    end

    set line1 '                 '$o'___'
    set line2 '  ___======____='$m'-'$i'-'$m'-='$o')'
    set line3 '/T            \_'$i'--='$m'=='$o')'
    set line4 $mouth' \ '$m'('$i$eye$m')   '$o'\~    \_'$i'-='$m'='$o')'
    set line5 ' \      / )J'$m'~~    '$o'\\'$i'-='$o')'
    set line6 '  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)'
    set line7 '   \_____/JJJ'$m'~~'$i'~~    '$o'\\'
    set line8 '   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\'
    set line9 '  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_'
    set linea '  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__'
    set lineb '   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\'
    set linec '          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)'
    set lined '                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)'
    set linee '                      (J'$m'JJ'$o'| \UUU)'
    set linef '                       (UU)'

    echo "$pad$line1"
    echo "$pad$line2"
    echo "$pad$line3"
    echo "$pad$line4"
    echo "$pad$line5"
    echo "$pad$line6"
    echo "$pad$line7"
    echo "$pad$line8"
    echo "$pad$line9"
    echo "$pad$linea"
    echo "$pad$lineb"
    echo "$pad$linec"
    echo "$pad$lined"
    echo "$pad$linee"
    echo "$pad$linef"

#     echo $pad'                 '$o'___
# '$pad'  ___======____='$m'-'$i'-'$m'-='$o')
# '$pad'/T            \_'$i'--='$m'=='$o')
# '$pad''$mouth' \ '$m'('$i$eye$m')   '$o'\~    \_'$i'-='$m'='$o')
# '$pad' \      / )J'$m'~~    '$o'\\'$i'-='$o')
# '$pad'  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)
# '$pad'   \_____/JJJ'$m'~~'$i'~~    '$o'\\
# '$pad'   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\
# '$pad'  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_
# '$pad'  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__
# '$pad'   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\
# '$pad'          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)
# '$pad'                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)
# '$pad'                      (J'$m'JJ'$o'| \UUU)
# '$pad'                       (UU)'(set_color normal)
end
