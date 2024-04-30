status is-interactive || exit

# TokyoNight Color Palette
set -l foreground \#c0caf5
set -l selection \#364a82
set -l comment \#565f89
# black
set -l color0  \#1E1E22
set -l color8  \#383841
# red
set -l color1  \#ff5555
set -l color9  \#ff6e67
# green
set -l color2  \#5af79e
set -l color10 \#5af79e
# yellow
set -l color3  \#f4f99d
set -l color11 \#ff9e64
# blue
set -l color4  \#9d7cd8
set -l color12 \#caa9fa
# magenta
set -l color5  \#ff79c6
set -l color13 \#ff92d0
# cyan
set -l color6  \#7dcfff
set -l color14 \#9aedfe
# white
set -l color7  \#bfbfbf
set -l color15 \#e6e6e6

# Syntax Highlighting Colors
set -g fish_color_autosuggestion $comment
set -g fish_color_cancel --background=$selection
set -g fish_color_command $color6
set -g fish_color_comment $comment
set -g fish_color_cwd $color2
set -g fish_color_cwd_root $color9
set -g fish_color_end $color11
set -g fish_color_error $color9
set -g fish_color_escape $color13
set -g fish_color_gray $comment
set -g fish_color_history_current --bold
set -g fish_color_host $color3
set -g fish_color_host_remote $color11
set -g fish_color_keyword $color5 --bold
set -g fish_color_match --background=$selection
set -g fish_color_normal $foreground
set -g fish_color_operator $color14
set -g fish_color_option $color11
set -g fish_color_param $color4
set -g fish_color_quote $color2
set -g fish_color_redirection $color14
set -g fish_color_search_match --background=$selection
set -g fish_color_selection --background=$selection
set -g fish_color_status $color9
set -g fish_color_user $color2
set -g fish_color_valid_path --underline

# Completion Pager Colors
set -g fish_pager_color_background $comment
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_prefix $color6

set -g fish_pager_color_progress $comment

set -g fish_pager_color_secondary_background $comment
set -g fish_pager_color_secondary_completion $foreground
set -g fish_pager_color_secondary_description $comment
set -g fish_pager_color_secondary_prefix $color6

set -g fish_pager_color_selected_background --background=$selection
set -g fish_pager_color_selected_completion $color6
set -g fish_pager_color_selected_description $foreground
set -g fish_pager_color_selected_prefix
