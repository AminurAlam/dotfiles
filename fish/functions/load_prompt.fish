# [ -n "$VIRTUAL_ENV" ] && set -l venv "(venv)"
# set -l cwd (prompt_pwd -D 2)
# set -l prompt_cwd (string replace -r '^'"/d/d/c/f"'($|/)' '≈$1' $cwd)
# [ -n "$SSH_CLIENT" ] && set -l prompt_name "$USER@ssh"
# jobs -q && set prompt_jobs "[$(count (jobs))J]"
# [ -n "$SSH_CLIENT" ] && set -l prompt_name "$USER@ssh"
# (set_color yellow) $prompt_name \


builtin functions -e fish_mode_prompt

function prompt_pwd
    set -l path "$PWD"

    # replacing $HOME -> ~
    set -l path (string replace -r '^'"$HOME"'($|/)' '~$1' $path)
    set -l path (string replace -r '^'"$PREFIX"'($|/)' '…$1' $path)

    # splitting to preserve last directory
    set -l all (string split -m 1 -r / $path)
    set -l path $all[1]
    set -l last $all[2..]

    # shortening and then rejoining
    echo -n (string join / (string replace -ar '(\.?[^/]{1})[^/]*' '$1' $path) $last )
end

function fish_right_prompt
    set -l exit_code $status
    [ $exit_code -ne 0 ] && set prompt_status "[$exit_code]"

    if [ $CMD_DURATION -gt 3600000 ]
        set -f time "[$(math -s 0 $CMD_DURATION/3600_000)h$(math -s 0 \($CMD_DURATION%3600_000\)/60_000)m]"
    else if [ $CMD_DURATION -gt 60000 ]
        set -f time "[$(math -s 0 $CMD_DURATION/60_000)m$(math -s 0 \($CMD_DURATION%60_000\)/1_000)s]"
    else if [ $CMD_DURATION -gt 800 ]
        set -f time "[$(math -s 1 $CMD_DURATION/1_000)s]"
    else if [ $CMD_DURATION -gt 10 ]
        set -f time "[$(echo $CMD_DURATION)ms]"
    end

    printf "%s%s" \
        (set_color $fish_color_error) $prompt_status \
        (set_color grey) $time
end

function fish_prompt
    echo
    printf "%b%b " \
        (set_color cyan) (git symbolic-ref --short HEAD 2>/dev/null) \
        (set_color $fish_color_cwd) (prompt_pwd)
    set_color normal
    [ (string length (prompt_pwd)) -gt 20 ] && printf "\n ❯ " || printf "❯ "
end
