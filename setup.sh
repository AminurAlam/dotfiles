yes "Y" | apt update
yes "Y" | apt upgrade

termux-setup-storage
termux-change-repo

apt install fish
curl -o setup.fish "https://raw.githubusercontent.com/AminurAlam/dotfiles/main/setup.fish"

echo "RUNNING FISH CONFIG"
fish setup.fish
chsh -s fish

echo "SETUP COMPLETE"
