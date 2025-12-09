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
iabbrev diff diff -Naur
iabbrev py python3 -q
iabbrev lg lazygit
iabbrev ff ffmpeg -y -hide_banner -stats -loglevel error -i % -vcodec copy -acodec copy -map 0:a
iabbrev gl git status -bs; git log --pretty=nice -n10
iabbrev gd git diff
iabbrev pull git pull origin
iabbrev push git push origin
iabbrev rsy rsync -Pha
iabbrev rcp rclone copy -P --transfers 8 --
iabbrev rls rclone lsf
iabbrev du dust -Dn 25
iabbrev dud dust -d 1
iabbrev pi yay -S
iabbrev pr yay -Rs
iabbrev pu yay -Syu
iabbrev puu sudo pacman -Syu
iabbrev pf yay -Ss
iabbrev pa yay -Si
]]
