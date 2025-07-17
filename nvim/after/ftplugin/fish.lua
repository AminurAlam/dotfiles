-- string unescape (abbr) | sed -E 's/^abbr.* -- (\S+) (.*)/iabbrev \1 \2/'
vim.cmd [[
iabbrev cp cp -ivr
iabbrev mv mv -iv
iabbrev rm rm -i
iabbrev rf rm -frI
iabbrev rd rmdir -pv
iabbrev md mkdir -pv
iabbrev vi nvim
iabbrev cls clear
iabbrev tar tar xzf
iabbrev yq yq -oj --xml-attribute-prefix ''
iabbrev qmv qmv -AXf do
iabbrev diff diff -Naur
iabbrev py python3 -q
iabbrev Listen rip url
iabbrev pst ps -faxo 'pid,comm' \| sed -E "s:$PREFIX/[a-z]+/::"
iabbrev fstack ffmpeg -y -hide_banner -i % -filter_complex hstack out.png
iabbrev ff ffmpeg -y -hide_banner -stats -loglevel error -i % -vcodec copy -acodec copy -map 0:a
iabbrev mbz python ~/repos/musicbrainzpy/cover_art.py -o $XDG_MUSIC_DIR/#meta/ '%'
iabbrev awk awk -F ' ' '{print $%}'
iabbrev komga KOMGA_CONFIGDIR=~/.local/share/komga komga \| awk '/^2025/{printf("%s %s ",substr($1,12,8),substr($2,0,1));for(i=9;i<=NF;i++)printf("%s ",$i);print""}'
iabbrev ... cd ../..
iabbrev .... cd ../../..
iabbrev yd y $HOME/repos/dotfiles/%
iabbrev ydl y $XDG_DOWNLOAD_DIR/%
iabbrev zd z $HOME/repos/dotfiles/%
iabbrev zdl z $XDG_DOWNLOAD_DIR/%
iabbrev zz z -
iabbrev gac git add % && git commit
iabbrev ga git add
iabbrev gc git commit
iabbrev gl git status -bs; git log --pretty=nice -n10
iabbrev gd git diff
iabbrev pull git pull origin
iabbrev push git push origin
iabbrev fr git fetch upstream && git rebase upstream/(git symbolic-ref refs/remotes/origin/HEAD \| sed s@^refs/remotes/origin/@@)
iabbrev rcp rclone copy -P --transfers 8 --
iabbrev rls rclone lsf
iabbrev rlt rclone tree --level
iabbrev rconf rclone config
iabbrev rsy rsync -Pha
iabbrev du dust -Dn 25
iabbrev dud dust -d 1
iabbrev df df -h \| awk '/fuse/{print $3"/"$2,$5,$4}'
iabbrev pi pacman -S
iabbrev pr pacman -Rs
iabbrev pu pacman -Syu
iabbrev pf pacman -Ss
iabbrev pa pacman -Si
]]
