: "
———————————————————————————————————————————————————————————————————
                        MUH FISH CONFIG
———————————————————————————————————————————————————————————————————
"

### main
cd
set fish_greeting "$(fish_logo cyan cyan green \| 0)"

### source
source $HOME/.config/fish/functions/prompt.fish
source $HOME/.config/fish/functions/fish_logo.fish
# source $HOME/.config/fish/functions/starship.fish

source $HOME/.config/fish/completions/exa.fish
source $HOME/.config/fish/completions/pip.fish
source $HOME/.config/fish/completions/pkg.fish
source $HOME/.config/fish/completions/procs.fish
source $HOME/.config/fish/completions/rclone.fish
source $HOME/.config/fish/completions/starship.fish

### exports
set -x EDITOR "vi"
set -x EXA_COLORS "*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.png=36:\
*.flac=36:*.log=38;5;252:*.lrc=38;5;252:*.cue=38;5;39:*.apk=38;5;47:\
*.css=38;5;135:*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:\
*.html=38;5;202:*.json=38;5;3:*.jl=38;5;213:*.js=33:*.kt=35:\
*.lua=38;5;27:*.php=38;5;63:"

### paths
set --path mu "/sdcard/Music"
set --path py "/sdcard/Python"
set --path tx "/sdcard/termux"
set --path dl "/sdcard/Download"
set --path pi "/sdcard/Pictures"
set --path sp "$HOME/repos/samples"
