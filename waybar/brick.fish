#!/usr/bin/fish --no-config
while true
    if not nc -w3 -q3 -z (ssh -G brick | rg --replace '' '^(hostname|port) ') 2>/dev/null
        echo '{"text": "", "class": "ERROR"}' | jq --unbuffered -Mcr .
        sleep 30
        continue
    end

    ssh brick termux-battery-status | jq --unbuffered -Mcr '{
        text:  (.level | tostring),
        percentage:  .level,
        class: .status,
        alt: .status
    }'

    sleep 5
end
