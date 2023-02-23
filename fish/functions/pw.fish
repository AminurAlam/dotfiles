function pw
    set -f chars  'A-Za-z0-9|{[(<>)]}@&%#^$"`_:;!?|~+\-*/='
    set -f cmd 'tr -dc "$chars" </dev/urandom | head -c 32'

    printf "  %s  %s\n" \
    (eval $cmd) (eval $cmd) (eval $cmd) (eval $cmd) \
    (eval $cmd) (eval $cmd) (eval $cmd) (eval $cmd) \
    (eval $cmd) (eval $cmd) (eval $cmd) (eval $cmd) \
    (eval $cmd) (eval $cmd) (eval $cmd) (eval $cmd)
end
