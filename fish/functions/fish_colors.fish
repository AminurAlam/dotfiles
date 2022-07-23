function fish_colors --description 'Shows the various fish colors being used'
    set -l color_list (set -n | grep fish_color | grep -v __)
    if [ "$color_list" ]
        set -l bclr (set_color normal)
        set -l bold (set_color --bold)
        # printf "\n| %-38s | %-38s |\n" Variable Definition
        for var in $color_list
            set -l def $$var
            set -l clr (set_color $def)
            printf "$clr%-26s$bclr $bold%-26s$bclr\n" "$var" "$def"
        end
    end
end
