function __fish_print_hostnames --description 'Print a list of known hostnames'
    printf '%s\n' brick slab paper

    # cat ~/.ssh/config \
    #     | string replace -rfi '^\s*Host\s+(\S.*?)\s*$' '$1' \
    #     | rg -v '^= .*' \
    #     | string split ' ' \
    #     | string match -rv '[\*\?]' \
    #     | string match -rv '^(codeberg|github|gitlab|\d+\.\d+\.\d+\.\d+)' \
    #     | sort \
    #     | uniq

    # if nc -w1 -q1 -z (ssh -G brick | rg --replace '' '^(hostname|port) ') 2>/dev/null
    #     printf "%s\n" brick/(ssh brick zmx ls --short 2>/dev/null)
    # end

    # cat ~/.ssh/known_hosts \
    #     | string match -rv '^\s*[!*|@#]' \
    #     | string replace -rf '^\s*(\S+) .*' '$1' \
    #     | string split ',' \
    #     | string replace -r '\[?([^\]]+).*' '$1'

    return 0
end
