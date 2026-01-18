set ls "ls --group-directories-first -1AXNGshF"
alias l "$ls"
alias ll "$ls -lg"
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
abbr h helix
abbr adb ANDROID_USER_HOME="$XDG_DATA_HOME"/.android HOME="$XDG_DATA_HOME"/ adb
abbr cls clear
abbr tar "tar xzf"
abbr qmv "qmv -AXf do"
abbr diff "diff -Naur"
abbr py "python3 -q"
abbr ru "rip url"
abbr lg lazygit
abbr pst "ps -faxo 'pid,comm' | sed -E \"s:\$PREFIX/[a-z]+/::\""
abbr --set-cursor ff "ffmpeg -y -hide_banner -stats -loglevel error -i % -vcodec copy -acodec copy -map 0:a"
abbr --set-cursor --position anywhere awk "awk -F ' ' '{print \$%}'"

# navigating
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr --set-cursor zd 'z $HOME/repos/dotfiles/%'
abbr --set-cursor zdl 'z $XDG_DOWNLOAD_DIR/%'
abbr zz "z -"

# git
abbr gl "git status -bs; git log --pretty=nice -n10"
abbr gd "git diff"
abbr pull "git pull origin"
abbr push "git push origin"
abbr fr "git fetch upstream && git rebase upstream/(git symbolic-ref refs/remotes/origin/HEAD | sed s@^refs/remotes/origin/@@)"

# rclone/rsync
abbr rsy "rsync -Pha"
abbr rcp "rclone copy -P --transfers 8 --"
abbr rls "rclone lsf"

# du -> dust
abbr du "dust -Dn 25"
abbr dud "dust -d 1"
abbr df 'df --output=pcent,avail,target -h -x tmpfs -x efivarfs'
set -q TERMUX_VERSION && abbr df 'df -h | awk \'/fuse/{print $3"/"$2,$5,$4}\''

# pkg: https://wiki.archlinux.org/title/Pacman/Rosetta
if command -vq pacstall
    abbr pi pacstall -I
    abbr pr pacstall -R
    abbr pu pacstall -U "&&" pacstall -Up
    abbr pf pacstall -S
    abbr pa pacstall -Si

    set sudo (command -v sudo | path basename)

    abbr pii $sudo apt install
    abbr prr $sudo apt remove
    abbr puu $sudo apt update "&&" $sudo apt upgrade
    abbr pff apt search
    abbr paa apt show
else if command -vq apt
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
else if command -vq pacman
    set sudo (command -v sudo | path basename)

    abbr pi $sudo pacman -S
    abbr pr $sudo pacman -Rs
    abbr pu $sudo pacman -Syu
    abbr pf pacman -Ss
    abbr pa pacman -Si
end
