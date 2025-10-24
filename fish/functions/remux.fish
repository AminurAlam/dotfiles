function remux -d "mux multiple files into one"
    set inputs
    set maps -map 0:v

    set count 0
    for file in $argv
        set -a inputs -i "$file"

        file --mime -b "$file" | grep -vq '^(text/|application/subrip)'
        and set -a maps -map $count:a?
        set -a maps -map $count:s?

        set count (math $count+1)
    end
    # printf "%s\n"
    ffmpeg -hide_banner -stats -loglevel error $inputs -vcodec copy -acodec copy $maps out.mkv
end
