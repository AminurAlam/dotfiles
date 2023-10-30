function rar2zip -a input output

    command -vq unrar && command -vq zip || pacman -S --needed unrar zip

    if not [ -e "$input" ]
        echo "input file not provided"
        return 1
    end

    mkdir -p "$medium/" && printf "created $medium/"

    set -l filename (string split -rm1 "." "$input")[1]
    set -l medium "temp-$filename"
    [ -z "$output" ] && set -l output "$filename.zip"

    if [ -e "$output" ]
        [ (read -P 'overwrite $output? [y/N] ') = y ] || return 1
    end


    printf "extracting $input -> $medium/ ... "
    unrar x "$input" "$medium/" &>/dev/null || return 1
    printf "complete\n"

    printf "compressing $medium/ -> $output ... "
    zip -rmq "$output" "$medium/"
    printf "complete\n"
end
