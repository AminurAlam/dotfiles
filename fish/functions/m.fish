function m -d "wrapper around manpages"
    if [ -n "$argv" ]
        if man -w $argv &>/dev/null
            echo found! 1>&2
            man $argv
        else if command -vq $argv[1]
            if [ (count ($argv[1] --help)) -gt 5 ]
                echo showing long help 1>&2
                $argv[1] --help | nvim +Man!
            else if [ (count ($argv[1] -h)) -gt 5 ]
                echo showing short help 1>&2
                $argv[1] -h | nvim +Man!
            else if [ (count ($argv[1] help)) -gt 5 ]
                echo showing only help 1>&2
                $argv[1] help | nvim +Man!
            end
        end
    else
        nvim +Man!
    end
end
