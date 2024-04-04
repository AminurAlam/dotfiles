[ (fish -v | tr -dc [:digit:] ) -ge 360 ] && set -l cursor "--set-cursor" "%"
command -vq sudo && set sudo sudo

# common
abbr cp "cp -ivr"
abbr mv "mv -iv"
abbr rm "rm -i"
abbr rf "rm -frI"
abbr rd "rmdir -pv"
abbr md "mkdir -pv"
abbr vi nvim
abbr cls clear
abbr yq "yq -oj"
abbr cal "cal -my"
abbr qmv "qmv -AXf do"
abbr pst "ps -faxo 'pid,comm'"
abbr y "yes |"
abbr ffprobe "ffprobe -hide_banner -pretty"
abbr $cursor[1] ff "ffmpeg -y -hide_banner -stats -loglevel error -i $cursor[2] -strict -2 -vcodec copy -acodec copy -scodec copy -map 0:v -map 0:a -map 0:s"
abbr diff diff -Naur

# parent dir
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."

# git
abbr $cursor[1] gac "git add $cursor[2] && git commit"
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
# alias mbz "python3 \$XDG_PROJECTS_DIR/musicbrainzpy/cover_art.py"

# ls -> eza
set -l common "-las ext -F auto -I '.git*' --icons --no-user --group-directories-first --no-quotes --color-scale all --color-scale-mode fixed"
alias l  "eza $common --no-permissions --no-time"
alias ll "eza $common --git --total-size"
alias lt "eza $common -T --git --total-size --no-permissions --no-time"

# du, df -> dust, duf
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
abbr df 'df -h | awk \'/fuse/{printf(" %s (%3s) %5s/%-5s %4s free\n",($6~/emulated/)?"Int":"Ext",$5,$3,$2,$4)}\''

# tar
abbr tar-compress "tar cf"
abbr tar-compress-gz "tar czf"
abbr tar-extract "tar xf"
abbr tar-extract-gz "tar xzf"

if command -vq apt
    abbr pi $sudo apt install
    abbr pr $sudo apt remove
    abbr pu $sudo apt update "&&" $sudo apt upgrade
    abbr pf apt search
    abbr pa apt show
    [ (uname -o) = Android ] && echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" >$PREFIX/etc/apt/sources.list
else if command -vq pacman
    abbr pi $sudo pacman -S
    abbr pr $sudo pacman -Rs
    abbr pu $sudo pacman -Syu
    abbr pf pacman -Ss
    abbr pa pacman -Si
else if command -vq dnf
    abbr pi $sudo dnf install
    abbr pr $sudo dnf remove
    abbr pu $sudo dnf upgrade
    abbr pf dnf search
    abbr pa dnf show
end
