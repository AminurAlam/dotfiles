function __fish_print_hostnames --description 'Print a list of known hostnames'
    cat ~/.ssh/config \
        | string replace -rfi '^\s*Host\s+(\S.*?)\s*$' '$1' \
        | string split ' ' \
        | string match -rv '[\*\?]' \
        | string match -rv '^(codeberg|github|gitlab|\d+\.\d+\.\d+\.\d+)'

    # cat ~/.ssh/known_hosts \
    #     | string match -rv '^\s*[!*|@#]' \
    #     | string replace -rf '^\s*(\S+) .*' '$1' \
    #     | string split ',' \
    #     | string replace -r '\[?([^\]]+).*' '$1'

    return 0
end
