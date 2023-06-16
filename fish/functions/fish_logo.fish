function fish_logo # https://github.com/laughedelic/fish_logo
    set -l m (set_color brcyan)
    set -l i (set_color brgreen)
    set -l o (set_color brcyan)
    set -l pad (printf "%.0s " (seq (math -s 0 \($COLUMNS/2\) - 20)))

    echo $pad'                 '$o'___'
    echo $pad'  ___======____='$m'-'$i'-'$m'-='$o')'
    echo $pad'/T            \_'$i'--='$m'=='$o')'
    echo $pad'| \ '$m'('$i'0'$m')   '$o'\~    \_'$i'-='$m'='$o')'
    echo $pad' \      / )J'$m'~~    '$o'\\'$i'-='$o')'
    echo $pad'  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)'
    echo $pad'   \_____/JJJ'$m'~~'$i'~~    '$o'\\'
    echo $pad'   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\'
    echo $pad'  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_'
    echo $pad'  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__'
    echo $pad'   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\'
    echo $pad'          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)'
    echo $pad'                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)'
    echo $pad'                      (J'$m'JJ'$o'| \UUU)'
    echo $pad'                       (UU)'(set_color normal)
end
