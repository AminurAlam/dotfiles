function yy -d 'yazi debug helper'
    # pick bin
    set yazi (switch "$argv[1]"
        case release debug # use local build
            test -e ~/repos/yazi-fork/target/$argv[1]/yazi
            and echo ~/repos/yazi-fork/target/$argv[1]/yazi
        case stable # use stable version
            command -v yazi-stable
        case '*' # use installed yazi
            command -v yazi
    end)

    # run
    YAZI_LOG=debug $yazi $argv[2..] # 2>/dev/null
    and clear

    # print logs
    cat ~/.local/state/yazi/yazi.log | sed -E '
        /emulator(.rs)?|DDS server on /d;
        /\S*at\S* yazi-(plugin|dds)/d;
        /^\s*$/d;
        s/^.*[0-9-]+T[0-9:\.]+Z\S* //;
        s/^DEBUG yazi_plugin::utils::log: //; '
end
