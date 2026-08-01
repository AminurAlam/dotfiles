function __fish_print_hostnames --description 'Print a list of known hostnames'
    cat ~/.ssh/config \
        | string replace -rfi '^\s*Host\s+(\S.*?)\s*$' '$1' \
        | rg -v '^= .*' \
        | string split ' ' \
        | string match -rv '[\*\?]' \
        | string match -rv '^(codeberg|github|gitlab|\d+\.\d+\.\d+\.\d+)' \
        | sort \
        | uniq

    # nc -w3 -q3 -z (ssh -G $host | rg --replace '' '^(hostname|port) ') 2>/dev/null
    # and echo $host

    if set -q TERMUX_VERSION && nc -w3 -q3 -z (ssh -G arch | rg --replace '' '^(hostname|port) ') 2>/dev/null
        ssh arch zmx list --short
    else if [ $USER = fisher ] && nc -w3 -q3 -z (ssh -G brick | rg --replace '' '^(hostname|port) ') 2>/dev/null
        ssh brick zmx list --short
    end

    # cat ~/.ssh/known_hosts \
    #     | string match -rv '^\s*[!*|@#]' \
    #     | string replace -rf '^\s*(\S+) .*' '$1' \
    #     | string split ',' \
    #     | string replace -r '\[?([^\]]+).*' '$1'

    return 0
end
