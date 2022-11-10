function bm
    switch "$argv[1]"
        case help
            echo "bm find '/regex/' "
        case fd find
            cat $tx/backup/ff_bookmarks | rg -i "$argv[2]"
        case a add
            echo "not inplemented"
        case *
            echo "-_-"
    end
end
