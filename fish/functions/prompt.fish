



function fish_prompt
    set -l last_status $status
	[ $last_status -ne 0 ] && set prompt_status "[$last_status]"
	fish_is_root_user && set prompt_logo '# ' || set prompt_logo '> '

    echo -s -e \n \
	    (set_color $fish_color_error) $prompt_status \
	    (set_color cyan) (fish_git_prompt) ' '\
        (set_color green) (prompt_pwd) \
		(set_color normal) $prompt_logo
end

function fish_right_prompt
    [ $CMD_DURATION -gt 16 ] && set time "[$(echo $CMD_DURATION)ms]"
    [ $CMD_DURATION -gt 900 ] && set time "[$(math -s 2 $CMD_DURATION/1000)s]"	
    [ $CMD_DURATION -gt 60000 ] && set time "[$(math -s 2 $CMD_DURATION/60000)m]"	

    echo -s -e (set_color grey) $time
end
