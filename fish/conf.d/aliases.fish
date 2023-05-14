# common
abbr cp "cp -ivr"
abbr mv "mv -iv"
abbr rm "rm -i"
abbr rf "rm -rfI"
abbr rd "rmdir -pv"
abbr md "mkdir -pv"
abbr vi "nvim"
abbr cls "clear"
abbr cal "cal -my"
abbr qmv "qmv -f do"
abbr wget 'wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'
abbr ps "ps -faxo pid,command"
abbr bin-integrity "sha256sum --check /sdcard/main/termux/bin-checksums"
abbr n "nvim --cmd 'cd /sdcard/main/notes/'"

# parent dir
abbr .. "z .."
abbr ... "z ../.."
abbr .... "z ../../.."

# git
abbr gup "git add . && git commit && git push origin"
abbr gcp "git clone --depth 1"
abbr gd "git diff"
abbr ga "git status -s"
abbr gs "git status -s"
abbr gc "git checkout"
abbr gp "git pull origin"

# rclone
abbr rcp "rclone copy -P"
abbr rmv "rclone move -P"
abbr rls "rclone lsf"
abbr rlt "rclone tree --level"
abbr rdu "rclone size"
abbr rcat "rclone cat"
abbr rstat "rclone about"
abbr rconf "rclone config"

# python
alias py "python3 -q"
alias mbz "python3 ~/repos/musicbrainzpy/cover_art.py"

# ls -> exa
alias l  "exa -lFas ext --icons --no-user --group-directories-first --no-permissions --no-time"
alias lt "exa -lFTs ext --icons --no-user --group-directories-first --no-permissions --no-time"
alias ll "exa -lFas ext --icons --no-user --group-directories-first --git"

# du, df -> dust, duf
abbr du "dust -n 25"
abbr dud "dust -d 1"
alias df "duf -only local -output mountpoint,size,avail,usage -width 150 /storage/*"

# tar
abbr tar-compress    "tar cf"
abbr tar-compress-gz "tar czf"

abbr tar-extract    "tar xf"
abbr tar-extract-gz "tar xzf"

if command -sq apt
    abbr pi "apt install"
    abbr pr "apt remove"
    abbr pf "apt search"
    abbr pa "apt show"
    function pu
        echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
        apt update && apt upgrade
    end
else if command -sq pacman
    abbr pi "pacman -S"
    abbr pr "pacman -Rs"
    abbr pf "pacman -Ss"
    abbr pu "pacman -Syu"
    abbr pa "pacman -Si"
else if command -sq rpm
    abbr pi "rpm install"
    abbr pr "rpm remove"
    abbr pf "rpm search"
    abbr pa "rpm show"
else
    echo "UNKNOWN PACKAGE MANAGER"
end

if command -sq pip
    abbr pyi "pip install"
    abbr pyu "pip install --upgrade"
    abbr pyr "pip uninstall"
    abbr pyf "pip search"
end

if command -sq cargo
    abbr cb "cargo build"
    abbr cr "cargo run"
    abbr ct "cargo test"
    abbr cf "cargo search"
    abbr ci "cargo install"
end

if command -sq npm
    abbr ni "npm install --location global"
    abbr nr "npm uninstall"
    abbr nu "npm update"
end
