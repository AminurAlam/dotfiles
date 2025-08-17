set -l common "-las ext -F auto -I '.git*' --icons --no-user --group-directories-first --no-quotes --color-scale all --color-scale-mode fixed"
alias l "eza $common --no-permissions --no-time"
alias ll "eza $common --git --total-size"
alias lt "eza $common -T --git --total-size --no-permissions --no-time"
alias tldr 'curl -qs cht.sh/$argv # '

status is-interactive || exit # no need to source abbreviations

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
abbr pst "pstree -Th"
abbr Listen "rip url"
set -q TERMUX_VERSION && abbr pst "ps -faxo 'pid,comm' | sed -E \"s:\$PREFIX/[a-z]+/::\""
abbr --set-cursor fstack "ffmpeg -y -hide_banner -i % -filter_complex hstack out.png" # https://stackoverflow.com/questions/11552565/vertically-or-horizontally-stack-mosaic-several-videos-using-ffmpeg#33764934
abbr --set-cursor ff "ffmpeg -y -hide_banner -stats -loglevel error -i % -vcodec copy -acodec copy -map 0:a"
abbr --set-cursor mbz "python ~/repos/musicbrainzpy/cover_art.py -o \$XDG_MUSIC_DIR/#meta/ '%'"
abbr --set-cursor --position anywhere awk "awk -F ' ' '{print \$%}'"
abbr = command # replicate =command from zsh
abbr komga 'KOMGA_CONFIGDIR=~/.local/share/komga komga | awk \'/^2025/{printf("%s %s ",substr($1,12,8),substr($2,0,1));for(i=9;i<=NF;i++)printf("%s ",$i);print""}\''

# navigating
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr --set-cursor yd 'y $HOME/repos/dotfiles/%'
abbr --set-cursor ydl 'y $XDG_DOWNLOAD_DIR/%'
abbr --set-cursor zd 'z $HOME/repos/dotfiles/%'
abbr --set-cursor zdl 'z $XDG_DOWNLOAD_DIR/%'
abbr zz "z -"

# git
abbr --set-cursor gac "git add % && git commit"
abbr ga "git add"
abbr gc "git commit"
abbr gl "git status -bs; git log --pretty=nice -n10"
abbr gd "git diff"
abbr pull "git pull origin"
abbr push "git push origin"
abbr fr "git fetch upstream && git rebase upstream/(git symbolic-ref refs/remotes/origin/HEAD | sed s@^refs/remotes/origin/@@)"

# rclone/rsync
abbr rcp "rclone copy -P --transfers 8 --"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rconf "rclone config"
abbr rsy "rsync -Pha"

# du -> dust
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
abbr df 'df --output=pcent,avail,target -h -x tmpfs -x efivarfs'
set -q TERMUX_VERSION && abbr df 'df -h | awk \'/fuse/{print $3"/"$2,$5,$4}\''

# pkg
if command -vq apt
    set sudo (command -v sudo | path basename)

    abbr pi $sudo apt install
    abbr pr $sudo apt remove
    abbr pu $sudo apt update "&&" $sudo apt upgrade
    abbr pf apt search
    abbr pa apt show
else if command -vq yay
    abbr pi yay -S
    abbr pr yay -Rs
    abbr pu yay -Syu
    abbr puu sudo pacman -Syu
    abbr pf yay -Ss
    abbr pa yay -Si
else if command -vq paru
    abbr pi paru -S
    abbr pr paru -Rs
    abbr pu paru -Syu
    abbr pf paru -Ss
    abbr pa paru -Si
else if command -vq pacman
    set sudo (command -v sudo | path basename)

    abbr pi $sudo pacman -S
    abbr pr $sudo pacman -Rs
    abbr pu $sudo pacman -Syu
    abbr pf pacman -Ss
    abbr pa pacman -Si
end
