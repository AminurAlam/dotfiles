function s -d "ssh wrapper"

    if [ -z "$argv[1]" ]
        set argv (__fish_print_hostnames | sort | fzf)
    end

    if [ -z "$argv[1]" ]
        return 1
    end

    # TODO: auto update address if android.local is unavailable
    # TODO: auto update address if arch is unavailable

    ssh "$argv[1]"
end
