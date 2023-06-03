function avg
    set -l count (count $argv)
    set -l sum (echo $argv | sed 's/ / + /g')
    math "$sum"
    math " ($sum) / $count "
end
