# python
# alias py="python3 -q"
alias py="python -q"
alias mbz="python3 ~/repos/musicbrainzpy/cover_art.py"
alias iab="python3 ~/repos/python-tools/iab.py"
alias iar="python3 ~/repos/python-tools/iar.py"

# rclone
# alias rsy="rclone sync -P"
# alias rcp="rclone copy -P"
# alias rmv="rclone move -P"
#
# alias rls="rclone lsf"
# alias rlt="rclone tree --level"
# alias rdu="rclone size"
# alias rln="rclone link"
# alias rcat="rclone cat"
# alias rstat="rclone about"
# alias rconf="rclone config"
#
# alias rbkup="rclone sync -P bkup:Rips bkup:Rips.bkup --transfers 12"

function adir
    echo "
    function $argv[1]
        z $argv[2]
    end" | source
    echo "
    function l$argv[1]
        z $argv[2] && ls $argv[2]
    end" | source
end

adir ztest "/sdcard/Tachiyomi"

# cd -> (z)oxide
adir zz "-"
adir .. ".."
adir ... "../.."
adir .... "../../.."
adir ..... "../../../.."

adir zp "$PREFIX"
  adir zpb "$PREFIX/bin"
  adir zpe "$PREFIX/etc"
  adir zpl "$PREFIX/lib"
  adir zps "$PREFIX/share"

adir zsd "/sdcard"
adir zdoc "/sdcard/Documents"
adir zdl "/sdcard/Download"
adir zmov "/sdcard/Movies"
adir zmu "/sdcard/Music"
adir zpic "/sdcard/Pictures"
adir ztx "/sdcard/termux"
adir zt "/sdcard/Tachiyomi"
adir ztd "/sdcard/Tachiyomi/downloads"
adir ztl "/sdcard/Tachiyomi/local"

adir zn "$HOME/notes"
adir zrp "$HOME/repos"
  adir zd "$HOME/repos/dotfiles"
  adir zmbz "$HOME/repos/musicbrainzpy"
  adir zpy "$HOME/repos/python-tools"
  adir zsp "$HOME/repos/samples"
    adir zspsh "$HOME/repos/samples/bash"
    adir zspjs "$HOME/repos/samples/javascript"
    adir zsplua "$HOME/repos/samples/lua"
    adir zsppy "$HOME/repos/samples/python"
    adir zsprs "$HOME/repos/samples/rust"
adir zc "$HOME/.config"
  adir zcf "$HOME/.config/fish"
  adir zcn "$HOME/.config/nvim"

# yt-dlp
function yt
    yt-dlp -F $argv
    echo
    read choice -f -P ">pick one: "
    yt-dlp -f $choice $argv
end

# nvim
alias vi="nvim"
alias vim="nvim"
alias vn="cd ~/.config/nvim/ && vi -c 'Telescope find_files'"
alias vf="cd ~/.config/fish/ && vi -c 'Telescope find_files'"

# exa
alias ls="exa -lF -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias la="exa -lFa -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias lg="exa -lF -s ext --icons --no-user --no-permissions --no-time --group-directories-first --git"
alias lt="exa -lFT -s ext --icons --no-user --no-permissions --no-time --group-directories-first --no-filesize"
alias lta="exa -lFTa -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias ll="exa -lFa -s ext --icons --no-user --group-directories-first --git"

# file management
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -i"
alias rf="rm -rfI"

alias rd="rmdir"
alias md="mkdir -pv"

# bat -> cat
# alias cat="bat --theme Dracula --style full --pager=never -ppf"
# alias bat="bat --theme Dracula --style full -f"
# alias batdiff="git diff --name-only --relative --diff-filter=d | xargs bat --diff"
# function help
#     $argv --help | bat -pp -l help
# end

# fuzzy finder
# alias fzf="fzf --cycle --scroll-off 4 --border=rounded --ellipsis …"
# alias fz="z (fd . -t d | fzf)"

# du, df -> dust, duf
alias du="dust -n 25"
alias dut="dust -n 30 -t"
alias dud="dust -d 1"
alias anal="command du -ah -d 1 -t 20000000 | sort -k1hr"
alias df="duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# others
alias nb="newsboat"
alias tdl="tidal-dl -l"
alias wdu="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts --spider"
alias wdl="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias cal="cal -my"
alias mi="mediainfo"
alias cls="clear && fish_logo cyan cyan green \| 0"
