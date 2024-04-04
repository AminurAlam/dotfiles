function avg
    math "($(string join '+' $argv))" / (count $argv)
end
