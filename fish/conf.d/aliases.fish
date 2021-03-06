# python
alias py="python3 -q"
alias mbz="python3 ~/repos/musicbrainzpy/cover_art.py"

alias iab="python3 ~/repos/python-tools/iab.py"
alias iar="python3 ~/repos/python-tools/iar.py"
alias dibot="python3 ~/repos/python-tools/dibot.py && procs && fg"
alias renum="python3 ~/repos/python-tools/renum.py"
alias retag="python3 ~/repos/python-tools/retag.py"
alias rename="python3 ~/repos/python-tools/rename.py"

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

# git
alias gadd="git add ."
alias gmv="git mv"
alias gcomm="git commit"
alias gcp="git clone"
alias gclone="git clone"
alias ginit="git init"
alias glog="git log"
alias gdiff="git diff"
alias gstat="git status"
alias grau="git remote add upstream"
alias gcm="git commit -m"
alias gpull="git pull origin"
alias gpush="git push origin"
alias gupload="git add . && git commit && git push origin"

# cd -> (z)oxide
alias z-="z -"
alias .="z"
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."

alias zmu="z /sdcard/Music/"
alias ztx="z /sdcard/termux"
alias zdl="z /sdcard/Download"
alias zpi="z /sdcard/Pictures"
alias zlrc="z /sdcard/Music/meta/lrc"

alias zrp="z ~/repos"
  alias zdeflac="z ~/repos/deflacue"
  alias zdr14="z ~/repos/dr14meter"
  alias zexa="z ~/repos/exa"
  alias zmbz="z ~/repos/musicbrainzpy"
  alias zpy="z ~/repos/python-tools"
  alias zsp="z ~/repos/samples"
    alias zspsh="z ~/repos/samples/bash"
    alias zspjs="z ~/repos/samples/javascript"
    alias zsplua="z ~/repos/samples/lua"
    alias zsppy="z ~/repos/samples/python"
    alias zsprs="z ~/repos/samples/rust"
  alias zurban="z ~/repos/urban"
alias zc="z ~/.config"
  alias zcf="z ~/.config/fish"
  alias zcn="z ~/.config/nvim"
  alias zcr="z ~/.config/rclone"
alias zd="z ~/dotfiles"
  alias zdf="z ~/dotfiles/fish"
  alias zdg="z ~/dotfiles/git"
  alias zdv="z ~/dotfiles/nvim"
  alias zdr="z ~/dotfiles/ranger"
  alias zdt="z ~/dotfiles/termux"


# yt-dlp
alias yt="yt-dlp -F"
alias ytF="yt-dlp -F"
alias ytf="yt-dlp -f"

# nvim
alias vic="vi ~/.config/nvim/init.lua"
alias vip="vi ~/.config/nvim/lua/plugins.lua"
alias via="vi ~/.config/fish/conf.d/aliases.fish ~/.config/fish/conf.d/pm_aliases.fish +/^#"
alias vif="vi ~/.config/fish/config.fish"

# exa
alias ls="exa -lF -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias lg="exa -lF -s ext --icons --no-user --no-permissions --no-time --group-directories-first --git"
alias la="exa -laF -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias lt="exa -laTF -s ext --icons --no-user --no-permissions --no-time --group-directories-first"
alias ll="exa -lF -s ext --icons --group-directories-first --git"
alias lla="exa -lFa -s ext --icons --group-directories-first --git"
alias ld="exa -a | rg '/'"
alias l.="exa -a | rg '^\.'"

# file management
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias rf="rm -rfI"

alias rd="rmdir"
alias md="mkdir"

# bat -> cat
alias cat="bat --theme Dracula --style full --pager=never -ppf"
alias bat="bat --theme Dracula --style full -f"
alias batdiff="bat --theme Dracula --style full -d"

# fuzzy finder
alias fzf="fzf --cycle --scroll-off 4 --border=rounded --ellipsis ???"
alias fvi="vi (fzf --preview 'bat --color=always ./{}' --preview-window top)"
alias fz="z (fd . -t d | fzf)"
alias fcat="bat (fzf)"
alias fbat="bat (fzf)"

# du -> dust
alias du="dust -r -n 30"
alias dut="dust -r -n 30 -t"
alias dud="dust -r -d 1"
alias anal="$PATH/du -ah -d 1 -t 20000000 | sort -k1hr"

# others
alias nf="neofetch"
alias nano="nano -x -e"
alias tdl="tidal-dl -l"
alias wdu="wget --spider"
alias wsize="wget --spider"
alias dr="dr14_tmeter -d"
alias dr14="dr14_tmeter -d"
alias less="less --use-color"
alias cal="cal -my"
alias mi="mediainfo"
alias ping="gping google.com 8.8.8.8 discord.com 1.1.1.1\
            -c blue cyan green yellow --vertical-margin 0"
