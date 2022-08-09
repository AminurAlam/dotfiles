function fish_prompt
    [ -n "$SSH_CLIENT" ] && set -l prompt_name "$USER@ssh"
	[ -n "$VIRTUAL_ENV" ] && set -l venv "(venv)"
    fish_is_root_user && set -l prompt_logo '# ' || set -l prompt_logo ' ❯ '

    set -l cwd (prompt_pwd -D 2)
	set -l prompt_cwd (string replace -r '^'"/d/d/c/f"'($|/)' '≈$1' $cwd)

    echo -s -e \n \
        (set_color yellow) $prompt_name \
		(set_color blue) $venv \
        (set_color cyan) (fish_git_prompt) ' ' \
        (set_color $fish_color_cwd) $prompt_cwd \
        (set_color normal) $prompt_logo
end


function fish_right_prompt
    set -l last_status $status
    [ $last_status -ne 0 ] && set prompt_status "[$last_status]"
    jobs -q && set prompt_jobs "[$(count (jobs)) job]"

    [ $CMD_DURATION -gt 10 ] && set time "[$(echo $CMD_DURATION)ms]"
    [ $CMD_DURATION -gt 800 ] && set time "[$(math -s 2 $CMD_DURATION/1_000)s]"
    [ $CMD_DURATION -gt 60000 ] && set time "[$(math -s 2 $CMD_DURATION/60_000)m]"
    [ $CMD_DURATION -gt 3600000 ] && set time "[$(math -s 2 $CMD_DURATION/3600_000)h]"

    echo -s -e \
        (set_color $fish_color_error) $prompt_status \
        (set_color grey) $prompt_jobs $time \
        (set_color normal)
end
