function pw
    sleep 0.0(random 1 100)
    for __ in (seq 8)
        sleep 0.0(random 1 100)
        tr -dc 'A-Za-z0-9|{[(<>)]}@&%#^$"`_:;!?|~+\-*/=' </dev/urandom | head -c 32
        echo
    end
end
