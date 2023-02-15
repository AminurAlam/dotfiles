function fish_colors
    set -l bclr (set_color normal)
    for var in (set -n | grep _color)
        set -l clr (set_color $$var)
        printf "$clr%-50s $clr%-1s$bclr\n" "$var$bclr" "$$var"
    end
end
