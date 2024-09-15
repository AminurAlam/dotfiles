function min2hour
    echo (math -s0 $argv[1]/60):(math $argv[1]%60 )
end
