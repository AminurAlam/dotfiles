# python
# alias py="python3 -q"
alias py "python -q"
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

# cd -> (z)oxide
alias zz "z -"
alias .. "z .."
alias ... "z ../.."
alias .... "z ../../.."
alias ..... "z ../../../.."

[ -d "$EXTERNAL_STORAGE" ] || export EXTERNAL_STORAGE="$HOME"

alias zp "z $PREFIX"
alias zsd "z /sdcard"
alias zdoc "z $EXTERNAL_STORAGE/Documents"
alias zdl "z $EXTERNAL_STORAGE/Download"
alias zmov "z $EXTERNAL_STORAGE/Movies"
alias zmu "z $EXTERNAL_STORAGE/Music"
alias zpic "z $EXTERNAL_STORAGE/Pictures"
alias zm "z $EXTERNAL_STORAGE/main"
alias zt "z $EXTERNAL_STORAGE/Tachiyomi"
alias ztl "z $EXTERNAL_STORAGE/Tachiyomi/local"
alias zn "z $EXTERNAL_STORAGE/main/notes"

alias zrp "z $HOME/repos"
alias zmbz "z $HOME/repos/musicbrainzpy"
alias zd "z $HOME/repos/dotfiles"
alias zc "z $HOME/.config"
alias zcf "z $HOME/.config/fish"
alias zcn "z $HOME/.config/nvim"

# yt-dlp
function yt
    yt-dlp -F $argv
    echo
    read choice -f -P ">pick one: "
    yt-dlp -f $choice $argv
end

# nvim
alias vi "nvim"
alias vim "nvim"
alias vm "nvim ~/repos/musicbrainzpy/cover_art.py"
alias vn "cd ~/.config/nvim/ && nvim -c 'Telescope find_files'"
alias vf "cd ~/.config/fish/ && nvim -c 'Telescope find_files'"
alias note "cd $EXTERNAL_STORAGE/main/notes/ && nvim -c 'Telescope find_files'"

# exa
alias ls "exa -lF -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias la "exa -lFa -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias lg "exa -lF -s ext --icons --no-user --no-permissions --no-time --group-directories-first --git"
alias lt "exa -lFT -s ext --icons --no-user --no-permissions --no-time --group-directories-first --no-filesize"
alias lta "exa -lFTa -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias ll "exa -lFa -s ext --icons --no-user --group-directories-first --git"

# file management
alias cp "cp -iv"
alias mv "mv -iv"
alias rm "rm -i"
alias rf "rm -rfI"

alias rd "rmdir"
alias md "mkdir -pv"

# bat -> cat
# alias cat "bat --theme Dracula --style full --pager=never -ppf"
# alias bat "bat --theme Dracula --style full -f"
# alias batdiff "git diff --name-only --relative --diff-filter=d | xargs bat --diff"
# function help
#     $argv --help | bat -pp -l help
# end

# fuzzy finder
# alias fzf "fzf --cycle --scroll-off 4 --border=rounded --ellipsis …"
# alias fz "z (fd . -t d | fzf)"

# du, df -> dust, duf
alias du "dust -n 25"
alias dud "dust -d 1"
alias df "duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# tar
alias compress-tar-gz "tar czf"
alias extract-tar-gz "tar xzvf"

# others
alias ua "random choice (cat $m/notes/user_agents)"
alias nb "newsboat"
alias tdl "tidal-dl -l"
alias wdu "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts --spider"
alias wdl "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias wget "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias cal "cal -my"
alias mi "mediainfo"
alias cls "clear && fish_logo brcyan brcyan brgreen \| 0"
alias wa "curl -s https://api.wolframalpha.com/v1/result?appid=PJHXKQ-UP492G48WW&i=$(echo $argv | string escape --style=url) && :"
