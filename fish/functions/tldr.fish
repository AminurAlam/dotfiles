function tldr
    set -f arg (echo $argv | string escape --style=url)
    curl -s "cht.sh/$arg"
end
