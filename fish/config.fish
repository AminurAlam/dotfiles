### exports ###
export VISUAL="vi"
export EDITOR="vi"
export MANPAGER="vi +Man!"
export BAT_PAGER="less"
export LESSHISTFILE="-"
export EXA_COLORS="*.py=38;5;45:*.rs=38;5;208:*.fish=38;5;47:*.png=36:*.flac=36:\
*.log=38;5;252:*.lrc=38;5;252:*.cue=38;5;39:*.apk=38;5;47:*.css=38;5;135:\
*.csv=38;5;42:*.go=38;5;45:*.gradle=38;5;24:*.html=38;5;202:*.json=38;5;3:\
*.jl=38;5;213:*.js=33:*.kt=35:*.lua=38;5;27:*.php=38;5;63:"

[ "$EXTERNAL_STORAGE" ] || export EXTERNAL_STORAGE="$HOME"

export XDG_DOCUMENTS_DIR="$EXTERNAL_STORAGE/Books"
export XDG_DOWNLOAD_DIR="$EXTERNAL_STORAGE/Download"
export XDG_MUSIC_DIR="$EXTERNAL_STORAGE/Music"
export XDG_PICTURES_DIR="$EXTERNAL_STORAGE/Pictures"
export XDG_VIDEOS_DIR="$EXTERNAL_STORAGE/Movies"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export TEXDIR="$PATH/share/texlive"
export TEXMFLOCAL="$PATH/share/texlive/texmf-local"
export TEXMFSYSVAR="$PATH/share/texlive/texmf-var"
export TEXMFSYSCONFIG="$PATH/share/texlive/texmf-config"
export TEXMFVAR="$TEXMFSYSVAR"
export TEXMFCONFIG="$TEXMFSYSCONFIG"
export TEXMFHOME="$TEXMFLOCAL"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_INSTALL_ROOT="$CARGO_HOME"

export PATH="$PATH:$CARGO_HOME/bin:$PREFIX/bin/texlive"


### source ###
for function_file in ~/.config/fish/functions/*
    [ -f "$function_file" ]; and source $function_file
end

for completion_file in ~/.config/fish/completions/*
    [ -f "$completion_file" ]; and source $completion_file
end

for config_file in ~/.config/fish/conf.d/*
    [ -f "$cofig_file" ]; and source $completion_file
end


### main ###
cd
set fish_greeting \n"$(fish_logo cyan cyan green \| 0)"

### paths ###
set --path mu "/sdcard/Music"
set --path py "/sdcard/Python"
set --path tx "/sdcard/termux"
set --path dl "/sdcard/Download"
set --path pi "/sdcard/Pictures"
set --path mv "/sdcard/Movies"

set --path rp "$HOME/repos"
set --path sp "$HOME/repos/samples"

### bindings ###
bind \e\[1\;5A 'commandline -f history-token-search-backward'
bind \e\[1\;5B 'commandline -f history-token-search-forward'

bind \' "commandline -i \'\'" 'commandline -f backward-char'
bind \" 'commandline -i \"\"' 'commandline -f backward-char'
bind \` 'commandline -i \`\`' 'commandline -f backward-char'
bind \( 'commandline -i \(\)' 'commandline -f backward-char'
bind \[ 'commandline -i \[\]' 'commandline -f backward-char'
bind \{ 'commandline -i \{\}' 'commandline -f backward-char'
bind \< 'commandline -i \<\>' 'commandline -f backward-char'


### functions ###

# checking installations
set -l PAKS bat dust exa fd fzf git vi python rclone rg wget zoxide

for package in $PAKS
	set_color $fish_color_error
	if ! type -qf "$package"
		echo "`$package` is not installed"
	end
	set_color normal
end

# cleaning
function clean
    echo -e (set_color cyan) "\napt & pkg" (set_color normal)
	apt autoremove
	pkg clean
	pkg autoclean

	echo -e (set_color cyan) "\nsdcard folders" (set_color normal)
	echo -en (set_color red) "aurora"  (set_color normal)
	rm -rfI /sdcard/Aurora/
	echo -en (set_color red) "xodo" (set_color normal)
	rm -rfI /sdcard/Android/data/com.xodo.pdf.reader/
	echo -en (set_color red) "youtube" (set_color normal)
	rm -rfI /sdcard/Android/data/com.vanced.android.youtube/

    echo -e (set_color cyan) "\npython" (set_color normal)
	pip cache info
	pip cache purge
	
	echo -e (set_color cyan) "\nfiles in home" (set_color normal)
	count (ls -a $HOME)
end

