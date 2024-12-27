function x11
    command -vq termux-x11 || pacman -S termux-x11-nightly xfce4
    command -vq xfce4-session || pacman -S xfce4-session

    am start --user 0 -n com.termux.x11/.MainActivity

    [ -n "$argv[1]" ] &&
        termux-x11 :3 -xstartup $argv ||
        termux-x11 :3 -xstartup "dbus-launch --exit-with-session xfce4-session"
end
