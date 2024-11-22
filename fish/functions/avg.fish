function avg -d "find average of given numbers"
    math "($(string join '+' $argv))" / (count $argv)
end
