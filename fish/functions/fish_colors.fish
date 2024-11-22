function fish_colors -d "pretty print fish theme"
    for var in (set -n | grep -E 'fish_(pager_)?color_')
        printf "$(set_color $$var)%-40s %s$(set_color normal)\n" \
            "$var" "$$var"
    end
end
