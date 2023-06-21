function quit
    if [ (count (ps -C fish)) = 2 ]
        pkill com.termux
    else
        exit
    end
end

bind -M insert \cq quit
bind -M insert \cd quit
bind q quit
