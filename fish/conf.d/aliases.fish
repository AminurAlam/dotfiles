# common
abbr cp "cp -ivr"
abbr mv "mv -iv"
abbr rm "rm -i"
abbr rf "rm -frI"
abbr rd "rmdir -pv"
abbr md "mkdir -pv"
abbr vi "nvim"
abbr cls "clear"
abbr cal "cal -my"
abbr qmv "qmv -f do"
abbr wget "wget --hsts-file=\$XDG_CACHE_HOME/wget-hsts"
abbr pst "pstree -lhTUC age (pidof com.termux)" # "ps -faxo pid,command"
abbr bin-integrity "sha256sum --check /sdcard/main/termux/bin-checksums"

# parent dir
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# git
abbr gac "git add . && git commit"
abbr gpo "git push origin"
abbr gup "git add . && git commit && git push origin"
abbr gcp "git clone --depth 1"
abbr gl "git status -bs && git log --pretty=nice -n 10"
abbr gd "git diff | \$EDITOR +'set bt=nofile bh=hide'"
abbr gs "git status -bs"

# rclone
abbr rcp "rclone copy -P"
abbr rmv "rclone move -P"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rdu "rclone size"
abbr rcat "rclone cat"
abbr rstat "rclone about"
abbr rconf "rclone config"

# python
abbr py "python3 -q"
alias mbz "python3 \$XDG_PROJECTS_DIR/musicbrainzpy/cover_art.py"

# ls -> exa
alias l  "exa -lFas ext -I '.git*' --icons --no-user --group-directories-first --no-permissions --no-time"
alias lt "exa -lFTs ext -I '.git*' --icons --no-user --group-directories-first --no-permissions --no-time --git"
alias ll "exa -lFas ext -I '.git*' --icons --no-user --group-directories-first --git"

# du, df -> dust, duf
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
alias df "duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# tar
abbr tar-compress    "tar cf"
abbr tar-compress-gz "tar czf"
abbr tar-extract    "tar xf"
abbr tar-extract-gz "tar xzf"

if command -sq apt
    abbr pi "apt install"
    abbr pr "apt remove"
    abbr pf "apt search"
    abbr pa "apt show"
    function pu
        echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" >$PREFIX/etc/apt/sources.list
        apt update && apt upgrade
    end
else if command -sq pacman
    abbr pi "pacman -S"
    abbr pr "pacman -Rs"
    abbr pf "pacman -Ss"
    abbr pu "pacman -Syu"
    abbr pa "pacman -Si"
else if command -sq dnf
    abbr pi "dnf install"
    abbr pr "dnf remove"
    abbr pf "dnf search"
    abbr pa "dnf show"
else
    echo "UNKNOWN PACKAGE MANAGER"
end
