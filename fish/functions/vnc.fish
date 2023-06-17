function vnc
    command -vq vncserver || pacman -S tigervnc
    vncserver -localhost -geometry 1920x1080 :1 || vncserver -kill :1 &>/dev/null
end
