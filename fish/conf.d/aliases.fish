status is-interactive || exit

[ (fish -v | tr -dc [:digit:] ) -ge 360 ] && set -l cursor "--set-cursor" "%"
command -vq sudo && set sudo sudo

# common
abbr cp "cp -ivr"
abbr mv "mv -iv"
abbr rm "rm -i"
abbr rf "rm -frI"
abbr rd "rmdir -pv"
abbr md "mkdir -pv"
abbr vi "nvim"
abbr cls "clear"
abbr yq "yq -oj --xml-attribute-prefix ''"
abbr cal "cal -my"
abbr qmv "qmv -AXf do"
abbr y "yes |"
abbr diff "diff -Naur"
abbr ta "tmux attach -t"
abbr py "python3 -q"
abbr pst "ps -faxo 'pid,comm' | sed -E \"s:\$PREFIX/[a-z]+/::\""
abbr $cursor[1] ff "ffmpeg -y -hide_banner -stats -loglevel error -i $cursor[2] -strict -2 -vcodec copy -acodec copy -map 0:v -map 0:a"
abbr $cursor[1] --position anywhere awk "awk -F ' ' '{print \$$cursor[2]}'"

# replicate =command from zsh
function which_commander; command -v (string sub -s 2 $argv);  end
abbr --add equalcommand --regex '=\w+' --position anywhere --function which_commander

# parent dir
abbr ... "cd ../.."
abbr .... "cd ../../.."

# git
abbr $cursor[1] gac "git add $cursor[2] && git commit"
abbr ga "git add"
abbr gc "git commit"
abbr gl "git s; git l"
abbr gd "git d"
abbr gz "git switch"
abbr pull "git pull origin"
abbr push "git push origin"

# rclone
abbr rcp "rclone copy -P --transfers 8 --"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rdu "rclone size"
abbr rcat "rclone cat"
abbr rconf "rclone config"

# ls -> eza
set -l common "-las ext -F auto -I '.git*' --icons --no-user --group-directories-first --no-quotes --color-scale all --color-scale-mode fixed"
alias l  "eza $common --no-permissions --no-time"
alias ll "eza $common --git --total-size"
alias lt "eza $common -T --git --total-size --no-permissions --no-time"

# du -> dust
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

abbr $cursor[1] zdl 'z $XDG_DOWNLOAD_DIR/'$cursor[2]
abbr $cursor[1] zd 'z $XDG_PROJECTS_DIR/dotfiles/'$cursor[2]
abbr $cursor[1] zcf 'z $XDG_CONFIG_HOME/fish/'$cursor[2]
abbr $cursor[1] zcn 'z $XDG_CONFIG_HOME/nvim/'$cursor[2]
abbr $cursor[1] zp 'z $PREFIX/'$cursor[2]
abbr zz "z -"
