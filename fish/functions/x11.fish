function x11
    command -vq termux-x11 || pacman -S termux-x11-nightly xfce4
    am start --user 0 -n com.termux.x11/.MainActivity
    [ -n "$argv[1]" ] &&
        termux-x11 :1 -xstartup $argv ||
        termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session"
end
