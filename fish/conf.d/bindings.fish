fish_vi_key_bindings

# shortcuts to quit
bind -M insert \cq exit
bind -M insert \cd exit
bind q exit

# search current token in history
bind -M insert \e\[1\;5A 'commandline -f history-token-search-backward'
bind -M insert \e\[1\;5B 'commandline -f history-token-search-forward'

# delete from whitespace to cursor
bind -M insert \cv 'commandline -f backward-kill-bigword'

# helpful for toggling between processes
bind -M insert \cz fg
bind t fg

# press esc twice to cancel
bind \e cancel-commandline repaint-mode
