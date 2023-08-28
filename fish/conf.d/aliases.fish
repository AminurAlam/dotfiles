# common
abbr cp "cp -ivr"
abbr mv "mv -iv"
abbr rm "rm -i"
abbr rf "rm -frI"
abbr rd "rmdir -pv"
abbr md "mkdir -pv"
abbr vi nvim
abbr cls clear
abbr cal "cal -my"
abbr qmv "qmv -AXf do"
abbr pst "ps -faxo 'pid,comm'"
abbr y "yes |"

# parent dir
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# git
abbr gac "git add . && git commit"
abbr pull "git pull origin"
abbr push "git push origin"
abbr gl "git s; git l"
abbr gd "git d"
abbr gs "git s"

# rclone
abbr rcp "rclone copy -P --transfers 6 --"
abbr rmv "rclone move -P"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rdu "rclone size"
abbr rcat "rclone cat"
abbr rconf "rclone config"

# python
abbr py "python3 -q"
alias mbz "python3 \$XDG_PROJECTS_DIR/musicbrainzpy/cover_art.py"

# ls -> exa
alias l "exa -lFas ext -I '.git*' --icons --no-user --group-directories-first --no-permissions --no-time"
alias lt "exa -lFaTs ext -I '.git*' --icons --no-user --group-directories-first --no-permissions --no-time --git"
alias ll "exa -lFas ext -I '.git*' --icons --no-user --group-directories-first --git"

# du, df -> dust, duf
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
# alias df "duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# tar
abbr tar-compress "tar cf"
abbr tar-compress-gz "tar czf"
abbr tar-extract "tar xf"
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
end
