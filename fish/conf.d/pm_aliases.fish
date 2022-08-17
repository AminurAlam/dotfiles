# pip
alias pyin="pip install"
alias pydl="pip download"
alias pyup="pip install --upgrade"
alias pyun="pip uninstall"

alias pyls="pip list"
alias pylo="pip list -o"
alias pylu="pip list -o"
alias pyfd="pip search"

# pkg
alias pin="apt install"
alias pun="apt remove"

alias pls="apt list --installed"
alias pla="apt list"
alias plu="apt list --upgradeable"
alias pfd="apt search"
alias pinf="apt show"

# npm
alias nin="npm install"
alias nun="npm uninstall"
alias nup="npm update"

alias nls="npm ls"
alias nig="npm install --location global"

alias nrun="npm run"
alias ntest="npm test"
alias nstart="npm start"

# cargo
alias cin="cargo install"
alias cun="cargo uninstall"
alias cfd="cargo search --limit 30"

alias cnew="cargo new"  # create new project
alias crun="cargo run"  # run w/wo binary
alias cbuild="cargo build"  # compile binary in target/debug/…
alias crelease="cargo build --release"  # compile binary in target/release/…


function pup
	echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
	apt update && apt upgrade
end
