function out -d "compile and run c code in an instant"
    clear

    cc -lm -oout -- $argv[1]
    and ./out
    rm out
end
