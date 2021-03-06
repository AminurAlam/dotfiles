# TokyoNight Color Palette
set -l foreground \#c0caf5
set -l selection \#364A82
set -l comment \#565f89
set -l red \#ff6e67
set -l orange \#ff9e64
set -l yellow \#f4f99d
set -l green \#5af79e
set -l purple \#9d7cd8
set -l cyan \#7dcfff
set -l pink \#ff92d0  # bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $green
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $pink
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background

# others
set -g fish_color_cancel --background=$selection
set -g fish_color_cwd $green
set -g fish_color_cwd_root $red
set -g fish_color_history_current --bold
set -g fish_color_host
set -g fish_color_host_remote $yellow
set -g fish_color_status $red
set -g fish_color_user $green
set -g fish_color_valid_path --underline
