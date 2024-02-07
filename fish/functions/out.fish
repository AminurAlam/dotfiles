function out
    clear
    cc -lm -oout -- $argv[1] && ./out
end
