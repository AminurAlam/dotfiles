function out -d "compile and run c code in an instant"
    clear

    set ext (string split . $argv[1])[-1]

    if [ "$ext" = c ]
        cc -lm -oout -Wno-all -- $argv[1]
    else if [ "$ext" = rs ]
        rustc -oout -- $argv[1]
    end

    [ -e out ] && begin
        ./out
        rm out
    end
end
