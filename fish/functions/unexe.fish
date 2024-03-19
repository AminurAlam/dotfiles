function unexe
    [ -z $temp ] && set temp "$HOME/.local/cache/temp"
    mkdir -pv "$temp/exe"
    # pwd

    for file in *
        if [ -f "$file" ] && [ (command du "$file" | cut -f1) -lt 2048 ]
            echo "$file"
            mv "$file" "$temp/exe/"
        end
    end

    chmod -x "$temp/exe/"*
    mv "$temp/exe/"* ./
end
