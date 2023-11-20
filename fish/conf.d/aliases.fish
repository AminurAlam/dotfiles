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
abbr ffmpeg "ffmpeg -y -hide_banner -stats -loglevel error -i"

# parent dir
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# git
abbr gac "git add . && git commit"
abbr gc "git commit"
abbr pull "git pull origin"
abbr push "git push origin"
abbr gl "git s; git l"
abbr gd "git d"
abbr gs "git s"

# rclone
abbr rcp "rclone copy -P --transfers 8 --"
abbr rmv "rclone move -P"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rdu "rclone size"
abbr rcat "rclone cat"
abbr rconf "rclone config"

# python
abbr py "python3 -q"
alias mbz "python3 \$XDG_PROJECTS_DIR/musicbrainzpy/cover_art.py"

# ls -> eza
set -l common "--icons --no-user --group-directories-first --no-quotes --color-scale all --color-scale-mode fixed"
set -l heavy "--git --total-size"
set -l thin "--no-permissions --no-time"
alias l "eza -lFas ext -I '.git*' $common $thin"
alias ll "eza -lFas ext -I '.git*' $common $heavy"
alias lt "eza -lFaTs ext -I '.git*' $common $heavy $thin"

# du, df -> dust, duf
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
abbr df "df -ht fuse"

# tar
abbr tar-compress "tar cf"
abbr tar-compress-gz "tar czf"
abbr tar-extract "tar xf"
abbr tar-extract-gz "tar xzf"

if command -sq apt
    if [ (uname -o) = Android ]
        abbr pi "apt install"
        abbr pr "apt remove"
        function pu
            echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" >$PREFIX/etc/apt/sources.list
            apt update && apt upgrade
        end
    else
        abbr pi "sudo apt install"
        abbr pr "sudo apt remove"
        abbr pu "sudo apt update && sudo apt upgrade"
    end
    abbr pf "apt search"
    abbr pa "apt show"
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
