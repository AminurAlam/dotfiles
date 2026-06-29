#!/usr/bin/fish --no-config

command -vq niri-ipc-windowlayout || exit
command -vq jq || exit
test -e ".config/waybar/niri-windows.jq" || exit

niri-ipc-windowlayout | jq --unbuffered -rf $XDG_CONFIG_HOME/waybar/niri-windows.jq
