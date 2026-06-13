function fish_prompt --description 'commandline prompt'
    set -l last_status $pipestatus
    set -l stat
    if [ (math (string join + $last_status)) -gt 0 ]
        set stat (set_color --bold red) ✘ (string join '|' $last_status)
    end

    set -l user
    if [ -n "$SSH_TTY" ]
        set user (set_color $fish_color_host)  (switch $USER
            case u0_a312; echo brick
            case u0_a430; echo slab
            case u0_a293; echo paper
            case '*'; echo $USER
        end)
    end

    set -l pwd (set_color $fish_color_cwd)  (prompt_pwd)

    set -l job
    set -l jobcount (jobs | count)
    if [ $jobcount -gt 0 ]
        set job (set_color blue)  $jobcount
    end

    set -l git
    set branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]
        set git (set_color --bold purple)  $branch
    end

    set -l char '' '' \n' ❯'
    if [ "$fish_bind_mode" != insert ]
        set char (switch $fish_bind_mode
            case default f F t T
                set_color green
            case visual operator
                set_color blue
            case replace_one replace
                set_color red
            case '*'
                set_color --reset
        end) '' \n' '
    end

    echo
    printf " %s%s %s$(set_color --reset) " \
        $user \
        $pwd \
        $git \
        $job \
        $stat \
        $char
end
