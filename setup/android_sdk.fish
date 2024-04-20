set DEPENDENCIES gradle kotlin openjdk-19-jdk sdkmanager aapt

command -vq sudo && set sudo sudo

if command -vq apt
    set pm apt install
else if command -vq pacman
    set pm pacman -S --noconfirm --needed
else if command -vq dnf
    set pm dnf install
else
    printf "what arcane package manager are you using\n"
    exit
end

$sudo $pm -- $DEPENDENCIES

sdkmanager
yes | sdkmanager --licenses
