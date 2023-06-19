function tldr
    set -f arg (echo $argv | string escape --style=url)
    curl -qs "cht.sh/$arg"
end
