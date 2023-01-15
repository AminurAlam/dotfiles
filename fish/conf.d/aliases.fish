# python
alias py "python3 -q"
alias httpd "python3 -m http.server -d $XDG_DIR"
alias mbz "python3 ~/repos/musicbrainzpy/cover_art.py"

# rclone
alias rsy "rclone sync -P"
alias rcp "rclone copy -P"
alias rmv "rclone move -P"

alias rls "rclone lsf"
alias rlt "rclone tree --level"
alias rdu "rclone size"
alias rln "rclone link"
alias rcat "rclone cat"
alias rstat "rclone about"
alias rconf "rclone config"

# nvim
alias vi "nvim"
alias vm "nvim ~/repos/musicbrainzpy/cover_art.py"
alias vn "cd ~/.config/nvim/ && nvim -c 'Telescope find_files'"
alias vf "cd ~/.config/fish/ && nvim -c 'Telescope find_files'"
alias note "cd $EXTERNAL_STORAGE/main/notes/ && nvim -c 'Telescope find_files'"

# exa
alias l "exa -lFa -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias lt "exa -lFT -s ext --icons --no-user --no-permissions --no-time --group-directories-first --no-filesize"
alias ll "exa -lFa -s ext --icons --no-user --group-directories-first --git"

# du, df -> dust, duf
alias du "dust -n 25"
alias dud "dust -d 1"
alias df "duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# tar
alias compress-tar-gz "tar czf"
alias extract-tar-gz "tar xzvf"
