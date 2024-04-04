function out
    clear

    cc -lm -oout -- $argv[1]
    and ./out
    rm out
end
