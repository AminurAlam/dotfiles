: "
———————————————————————————————————————————————————————————————————
                        MUH FISH CONFIG
———————————————————————————————————————————————————————————————————
"

### source
for function_file in ~/.config/fish/functions/*
    [ -f "$function_file" ]; and source $function_file
end
for completion_file in ~/.config/fish/completions/*
    [ -f "$completion_file" ]; and source $completion_file
end
for config_file in ~/.config/fish/conf.d/*
    [ -f "$cofig_file" ]; and source $completion_file
end


### main
cd
set fish_greeting \n"$(fish_logo cyan cyan green \| 0)"

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
set --path rp "$HOME/repos"
set --path sp "$HOME/repos/samples"

### bindings
bind '[1;5A' "commandline -f history-token-search-backward"
