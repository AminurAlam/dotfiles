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
alias pin="pkg install"
alias pun="pkg uninstall"

alias pls="pkg list-installed"
alias pla="pkg list-all"
alias pfd="pkg search"
alias pinf="pkg info"

# apt
alias ain="apt install"
alias aun="apt remove"
alias aup="apt update && apt upgrade"

alias als="apt list --installed"
alias ala="apt list"
alias alu="apt list --upgradeable"
alias alo="apt list --upgradeable"

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

# others
function clean
	apt autoremove
	pkg clean
	pkg autoclean
	echo
	pip cache info
	pip cache purge
end

function pup
    set -f sources "https://packages.termux.dev/apt/termux-main" \
                   "https://packages-cf.termux.dev/apt/termux-main" \
                   "https://grimler.se/termux/termux-main"
	for source in $sources
		echo "deb $source stable main" > $HOME/../usr/etc/apt/sources.list
		apt update && apt upgrade
	end
end
