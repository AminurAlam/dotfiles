function fish_prompt --description 'commandline prompt'
    set last_status $pipestatus
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
    set jobcount (jobs | count)
    if [ $jobcount -gt 0 ]
        set job (set_color blue)  $jobcount
    end

    set -l bat
    if not set -q TERMUX_VERSION && [ -z "$WAYLAND_DISPLAY" ]
        set capacity (cat /sys/class/power_supply/BAT0/capacity)
        set bat_status (cat /sys/class/power_supply/BAT0/status)

        if [ -z "$capacity" ]
        else if [ "$bat_status" = Charging ]
            set bat (set_color blue)  $capacity
        else if [ "$bat_status" = "Not charging" ]
            set bat (set_color blue)  $capacity
        else if [ "$bat_status" = Discharging ]
            if [ "$capacity" -gt 75 ]
                set bat (set_color blue)  $capacity
            else if [ "$capacity" -gt 40 ]
                set bat (set_color green)  $capacity
            else if [ "$capacity" -gt 20 ]
                set bat (set_color yellow)  $capacity
            else
                set bat (set_color red)  $capacity
            end
        end
    end

    # TODO: network stuff
    # env LANG=en_US.UTF-8 nmcli general | tail -n1 | kt 4

    set -l git
    set -l push
    set branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]
        set git (set_color --bold purple)  $branch
        for r in (git remote)
            [ $r = upstream ] && continue

            set pushcount (git rev-list --count "$r..$branch")
            [ "$pushcount" = 0 ]
            and continue

            set icon 
            switch (git remote get-url $r | rg --only-matching --replace '$2' '(https://|git@)([^:/]+)')
                case github.com
                    set icon 
                case codeberg.org
                    set icon 
                case gitlab.archlinux.org
                    set icon 
                case brick
                    set icon 
            end

            set -a push (set_color brcyan) "$icon" "$pushcount"
        end
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
        $push \
        $bat \
        $job \
        $stat \
        $char
end
