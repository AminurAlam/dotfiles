### exports
export VISUAL="vi"
export EDITOR="vi"
export MANPAGER="vi +Man!"
export BAT_PAGER="less"
export LESSHISTFILE="-"
export EXA_COLORS="*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.png=36:*.flac=36:\
*.log=38;5;252:*.lrc=38;5;252:*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:\
*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:\
*.jl=38;5;213:*.js=33:*.kt=35:*.lua=38;5;27:*.php=38;5;63:"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export CONFIG="$XDG_CONFIG_HOME"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_INSTALL_ROOT="$CARGO_HOME"
export PATH="$PATH:$CARGO_HOME/bin"


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

# paths
set --path mu "/sdcard/Music"
set --path py "/sdcard/Python"
set --path tx "/sdcard/termux"
set --path dl "/sdcard/Download"
set --path pi "/sdcard/Pictures"
set --path mv "/sdcard/Movies"

set --path rp "$HOME/repos"
set --path sp "$HOME/repos/samples"

# bindings
bind '[1;5A' "commandline -f history-token-search-backward"

# checking installations
set -l PAKS bat dust exa fd fzf git vi python rclone rg wget zoxide

for package in $PAKS
	set_color $fish_color_error
	if ! type -qf "$package"
		echo "`$package` is not installed"
	end
	set_color normal
end
