# python
# alias py="python3 -q"
alias py="$(__fish_anypython) -q"
alias mbz="python3 ~/repos/musicbrainzpy/cover_art.py"

alias lfm="python3 ~/repos/python-tools/lfm.py"
alias iab="python3 ~/repos/python-tools/iab.py"
alias iar="python3 ~/repos/python-tools/iar.py"
alias renum="python3 ~/repos/python-tools/renum.py"
alias retag="python3 ~/repos/python-tools/retag.py"
alias rename="python3 ~/repos/python-tools/rename.py"
alias dibot="python3 ~/repos/python-tools/dibot.py && fg && procs -tp disable"
alias http="py ~/repos/http/server.py -d /sdcard/"

# rclone
alias rsy="rclone sync -P"
alias rcp="rclone copy -P"
alias rmv="rclone move -P"

alias rls="rclone lsf"
alias rlt="rclone tree --level"
alias rdu="rclone size"
alias rln="rclone link"
alias rcat="rclone cat"
alias rstat="rclone about"
alias rconf="rclone config"

alias rbkup="rclone sync -P bkup:Rips bkup:Rips.bkup --transfers 12"

# cd -> (z)oxide
alias zz="z -"
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."
alias .....="z ../../../.."

alias zp="z $PREFIX"
  alias zpb="z $PREFIX/bin"
  alias zpe="z $PREFIX/etc"
  alias zpl="z $PREFIX/lib"
  alias zps="z $PREFIX/share"

alias zsd="z /sdcard"
alias zdoc="z /sdcard/Documents"
alias zdl="z /sdcard/Download"
alias zmov="z /sdcard/Movies"
alias zmu="z /sdcard/Music"
alias zpic="z /sdcard/Pictures"
alias ztx="z /sdcard/termux"

set -l repo "$HOME/repos"
set -l sample "$repo/samples"

alias zn="z $HOME/notes"
alias zrp="z $repo"
  alias zd="z $repo/dotfiles"
  alias zmbz="z $repo/musicbrainzpy"
  alias zpy="z $repo/python-tools"
  alias zsp="z $sample"
    alias zspsh="z $sample/bash"
    alias zspjs="z $sample/javascript"
    alias zsplua="z $sample/lua"
    alias zsppy="z $sample/python"
    alias zsprs="z $sample/rust"
alias zc="z ~/.config"
  alias zcf="z ~/.config/fish"
  alias zcn="z ~/.config/nvim"

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
alias cat="bat --theme Dracula --style full --pager=never -ppf"
alias bat="bat --theme Dracula --style full -f"
alias batdiff="git diff --name-only --relative --diff-filter=d | xargs bat --diff"
function help
    $argv --help | bat -pp -l help
end

# fuzzy finder
alias fzf="fzf --cycle --scroll-off 4 --border=rounded --ellipsis …"
alias fz="z (fd . -t d | fzf)"

# du, df -> dust, duf
alias du="dust -r -n 25"
alias dut="dust -r -n 30 -t"
alias dud="dust -r -d 1"
alias anal="command du -ah -d 1 -t 20000000 | sort -k1hr"
alias df="duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# others
alias nb="newsboat"
alias tdl="tidal-dl -l"
alias wdu="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\" --spider"
alias wdl="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""
alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""
alias dr14="dr14_tmeter -d"
alias cal="cal -my"
alias mi="mediainfo"
alias cls="clear && fish_logo cyan cyan green \| 0"
# alias ping="gping google.com 8.8.8.8 discord.com 1.1.1.1 -c blue cyan green yellow --vertical-margin 0"
