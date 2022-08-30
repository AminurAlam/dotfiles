    # [ -n "$VIRTUAL_ENV" ] && set -l venv "(venv)"
    # set -l cwd (prompt_pwd -D 2)
    # set -l prompt_cwd (string replace -r '^'"/d/d/c/f"'($|/)' '≈$1' $cwd)
    # [ -n "$SSH_CLIENT" ] && set -l prompt_name "$USER@ssh"
    # jobs -q && set prompt_jobs "[$(count (jobs))J]"

function fish_mode_prompt
end

function prompt_pwd
    set -l path "$PWD"

    # replacing $HOME -> ~
    set -l path (string replace -r '^'"$HOME/notes"'($|/)' '$1' $path)
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

    [ $CMD_DURATION -gt 10 ] && set time "[$(echo $CMD_DURATION)ms]"
    [ $CMD_DURATION -gt 800 ] && set time "[$(math -s 2 $CMD_DURATION/1_000)s]"
    [ $CMD_DURATION -gt 60000 ] && set time "[$(math -s 2 $CMD_DURATION/60_000)m]"
    [ $CMD_DURATION -gt 3600000 ] && set time "[$(math -s 2 $CMD_DURATION/3600_000)h]"

    echo -se \
        (set_color $fish_color_error) $prompt_status \
        (set_color grey) $prompt_jobs $time \
        (fish_default_mode_prompt) \
        (set_color normal)
end

function fish_prompt
    # [ -n "$SSH_CLIENT" ] && set -l prompt_name "$USER@ssh"
    fish_is_root_user && set -l fish_color_cwd "$fish_color_cwd_root" # || set -l cwd_color "$fish_color_cwd"
    # fish_is_root_user && set -l prompt_logo ' # ' || set -l prompt_logo ' ❯ '
    __fish_is_git_repository && set -l prompt_logo "  " || set -l prompt_logo ' ❯ '
    __fish_is_git_repository && set -l git_branch (git symbolic-ref --short HEAD)
    [ (echo -n (prompt_pwd) $git_branch | wc -c) -gt (math -s 0 (tput cols)/3) ] && set -l prompt_logo "\n$prompt_logo"

    echo -se \n \
        (set_color yellow) $prompt_name \
        (set_color cyan) $git_branch ' ' \
        (set_color $fish_color_cwd) (prompt_pwd) \
        (set_color normal) $prompt_logo
end
