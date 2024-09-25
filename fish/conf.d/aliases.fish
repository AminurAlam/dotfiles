status is-interactive || exit
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
abbr tar "tar xzf"
abbr yq "yq -oj --xml-attribute-prefix ''"
abbr qmv "qmv -AXf do"
abbr diff "diff -Naur"
abbr py "python3 -q"
abbr pst "ps -faxo 'pid,comm' | sed -E \"s:\$PREFIX/[a-z]+/::\""
abbr --set-cursor fstack "ffmpeg -y -hide_banner -i % -filter_complex hstack out.png" # https://stackoverflow.com/questions/11552565/vertically-or-horizontally-stack-mosaic-several-videos-using-ffmpeg#33764934
abbr --set-cursor ff "ffmpeg -y -hide_banner -stats -loglevel error -i % -vcodec copy -acodec copy -map 0:a"
abbr --set-cursor mbz "python ~/repos/musicbrainzpy/cover_art.py -o \$XDG_MUSIC_DIR/#meta/ '%'"
abbr --set-cursor --position anywhere awk "awk -F ' ' '{print \$%}'"

# replicate =command from zsh
function which_commander
    command -v (string sub -s 2 $argv)
end
abbr --add equalcommand --regex '=\w+' --position anywhere --function which_commander

# parent dir
abbr ... "cd ../.."
abbr .... "cd ../../.."

# git
abbr --set-cursor gac "git add % && git commit"
abbr ga "git add"
abbr gc "git commit"
abbr gl "git s; git l"
abbr gd "git d"
abbr pull "git pull origin"
abbr push "git push origin"
abbr fr "git fetch upstream && git rebase upstream/(git symbolic-ref refs/remotes/origin/HEAD | sed s@^refs/remotes/origin/@@)"

# rclone
abbr rcp "rclone copy -P --transfers 8 --"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rdu "rclone size"
abbr rconf "rclone config"

# ls -> eza
set -l common "-las ext -F auto -I '.git*' --icons --no-user --group-directories-first --no-quotes --color-scale all --color-scale-mode fixed"
alias l "eza $common --no-permissions --no-time"
alias ll "eza $common --git --total-size"
alias lt "eza $common -T --git --total-size --no-permissions --no-time"

# du -> dust
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
abbr df 'df -h | awk \'/fuse/{print $3"/"$2,$5,$4}\''

# pkg
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

abbr --set-cursor zdl 'z $XDG_DOWNLOAD_DIR/%'
abbr --set-cursor zd 'z $XDG_PROJECTS_DIR/dotfiles/%'
abbr --set-cursor zf 'z $XDG_PROJECTS_DIR/dotfiles/fish/%'
abbr --set-cursor zn 'z $XDG_PROJECTS_DIR/dotfiles/nvim/%'
abbr --set-cursor zp 'z $PREFIX/%'
abbr zz "z -"
