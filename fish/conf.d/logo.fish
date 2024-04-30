status is-interactive || exit

set -l m (set_color brcyan)
set -l i (set_color brgreen)
set -l o (set_color brcyan)
set -l pad (string repeat -Nn (math -s 0 "($COLUMNS/2) - 20") " ")

set fish_greeting $pad'                 '$o'___'\n \
    $pad'  ___======____='$m'-'$i'-'$m'-='$o')'\n \
    $pad'/T            \_'$i'--='$m'=='$o')'\n \
    $pad'| \ '$m'('$i'0'$m')   '$o'\~    \_'$i'-='$m'='$o')'\n \
    $pad' \      / )J'$m'~~    '$o'\\'$i'-='$o')'\n \
    $pad'  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)'\n \
    $pad'   \_____/JJJ'$m'~~'$i'~~    '$o'\\'\n \
    $pad'   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\'\n \
    $pad'  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_'\n \
    $pad'  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__'\n \
    $pad'   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\'\n \
    $pad'          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)'\n \
    $pad'                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)'\n \
    $pad'                      (J'$m'JJ'$o'| \UUU)'\n \
    $pad'                       (UU)'
