# python
alias py "python3 -q"
alias mbz "python3 ~/repos/musicbrainzpy/cover_art.py"

# rclone
alias rcp "rclone copy -P"
alias rmv "rclone move -P"

alias rls "rclone lsf"
alias rlt "rclone tree --level"
alias rdu "rclone size"
alias rcat "rclone cat"
alias rstat "rclone about"
alias rconf "rclone config"

# nvim
alias vm "nvim ~/repos/musicbrainzpy/cover_art.py"
alias vn "cd ~/.config/nvim/ && nvim -c 'Telescope find_files'"
alias vf "cd ~/.config/fish/ && nvim -c 'Telescope find_files'"
alias n  "cd $EXTERNAL_STORAGE/main/notes/ && nvim -c 'Telescope find_files'"

# ls -> exa
alias l  "exa -lFa -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias lt "exa -lFT -s ext --icons --no-user --no-permissions --no-time --group-directories-first --no-filesize"
alias ll "exa -lFa -s ext --icons --no-user --group-directories-first --git"

# du, df -> dust, duf
alias du "dust -n 25"
alias dud "dust -d 1"
alias df "duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# tar
alias tar-compress    "tar cf"
alias tar-compress-gz "tar czf"

alias tar-extract    "tar xf"
alias tar-extract-gz "tar xzf"

alias tar-extract-verbose    "tar xvf"
alias tar-extract-verbose-gz "tar xvzf"
