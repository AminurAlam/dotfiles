#!/data/data/com.termux/files/usr/bin/fish

[ -e /sdcard/main/notes/bookmarks ] && echo "$argv[1]" >>/sdcard/main/notes/bookmarks || echo "$argv[1]" >>~/bookmarks

# url="$1"
# title="$2"
# description="$3"
# feed_title="$4"
# echo -e "${url}\t${title}\t${description}\t${feed_title}" >> ~/bookmarks.txt
