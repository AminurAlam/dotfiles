# set -q VIRTUAL_ENV && set -l venv "(venv)"
# set -l cwd (prompt_pwd -D 2)
# set -l prompt_cwd (string replace -r '^'"/d/d/c/f"'($|/)' '≈$1' $cwd)
# set -q SSH_CLIENT && set -l prompt_name "$USER@ssh"
# jobs -q && set prompt_jobs "[$(count (jobs))J]"
# set -q SSH_CLIENT && set -l prompt_name "$USER@ssh"
# (set_color yellow) $prompt_name \

builtin functions -e fish_mode_prompt

function fish_right_prompt
    set -l exit_code $status
    [ $exit_code -ne 0 ] && set prompt_status "[$exit_code]"

    if [ $CMD_DURATION -gt 3600000 ]
        set -f time "["(math -s 0 $CMD_DURATION/3600000)"h"(math -s 0 \($CMD_DURATION%3600_000\)/60_000)"m]"
    else if [ $CMD_DURATION -gt 60000 ]
        set -f time "["(math -s 0 $CMD_DURATION/60000)"m"(math -s 0 \($CMD_DURATION%60_000\)/1_000)"s]"
    else if [ $CMD_DURATION -gt 800 ]
        set -f time "["(math -s 1 $CMD_DURATION/1000)"s]"
    else if [ $CMD_DURATION -gt 10 ]
        set -f time "["(echo $CMD_DURATION)"ms]"
    end

    printf '%s%s' \
        (set_color $fish_color_error) $prompt_status \
        (set_color grey) $time
end

function fish_prompt
    echo
    printf '%b%b ' \
        (set_color cyan) (git symbolic-ref --short HEAD 2>/dev/null) \
        (set_color $fish_color_cwd) (prompt_pwd)
    set_color normal
    [ (string length (prompt_pwd)) -gt 20 ] && printf '\n ❯ ' || printf '❯ '
end
