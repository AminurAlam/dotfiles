status is-interactive || exit

fish_vi_key_bindings

bind q exit # shortcuts to quit
bind -M insert \cz 'jobs -q && fg' # helpful for toggling between processes
bind -M insert \cv 'commandline -f backward-kill-bigword' # delete from whitespace to cursor

# search current token in history
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'

bind -M insert \ct 'termux-reload-settings'
bind -M insert \c^ 'termux-reload-settings'
# bind -M insert \$ 'termux-reload-settings'
