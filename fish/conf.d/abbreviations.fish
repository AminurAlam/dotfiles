abbr cp "cp -ivr"
abbr mv "mv -iv"
if command -sq rip
    abbr rm "rip -i"
    abbr rf "rip -d"
else
    abbr rm "rm -i"
    abbr rf "rm -rfI"
    abbr rd "rmdir"
end
abbr vi "nvim"
abbr md "mkdir -pv"
abbr cls "clear"
abbr cal "cal -my"
abbr qmv "qmv -f do"
abbr wget "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

abbr -ag gup "git add . && git commit && git push origin"
abbr -ag gcp "git clone --depth 1"

abbr -ag gd "git diff"
abbr -ag ga "git status -s"
abbr -ag gs "git status -s"
abbr -ag gc "git checkout"
abbr -ag grau "git remote add upstream"
abbr -ag gp "git pull origin"
