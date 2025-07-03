status is-interactive || exit

[ "$USER" = student ] && exit

set -l i (set_color brgreen)
set -l o (set_color brcyan)

set fish_greeting \
    '                   '$o'___'\n \
    '    ___======____='$o'-'$i'-'$o'-='$o')'\n \
    '  /T            \_'$i'--='$o'=='$o')'\n \
    '  | \ '$o'('$i'0'$o')   '$o'\~    \_'$i'-='$o'='$o')'\n \
    '   \      / )J'$o'~~    '$o'\\'$i'-='$o')'\n \
    '    \\\\___/  )JJ'$o'~'$i'~~   '$o'\)'\n \
    '     \_____/JJJ'$o'~~'$i'~~    '$o'\\'\n \
    '     '$o'/ '$o'\  '$i', \\'$o'J'$o'~~~'$i'~~     '$o'\\'\n \
    '    (-'$i'\)'$o'\='$o'|'$i'\\\\\\'$o'~~'$i'~~       '$o'L_'$i'_'\n \
    '    '$o'('$o'\\'$o'\\)  ('$i'\\'$o'\\\)'$o'_           '$i'\=='$o'__'\n \
    '     '$o'\V    '$o'\\\\'$o'\) =='$o'=_____   '$i'\\\\\\\\'$o'\\\\'\n \
    '            '$o'\V)     \_) '$o'\\\\'$i'\\\\JJ\\'$o'J\)'\n \
    '                        '$o'/'$o'J'$i'\\'$o'J'$o'T\\'$o'JJJ'$o'J)'\n \
    '                        (J'$o'JJ'$o'| \UUU)'\n \
    '                         (UU)'
