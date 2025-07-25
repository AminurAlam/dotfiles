status is-interactive || exit

fish_vi_key_bindings

bind yy fish_clipboard_copy
bind p fish_clipboard_paste

bind q exit # shortcuts to quit
bind -M insert ctrl-\; "history -n1 | fish -P" # TODO: needs more testing
bind -M insert ctrl-z 'if jobs -q; fg; else; mux; end' # helpful for toggling between stuff
bind -M insert ctrl-v backward-kill-bigword # delete from whitespace to cursor
bind -M insert ctrl-d exit

# search current token in history
bind -M insert ctrl-up history-token-search-backward
bind -M insert ctrl-down history-token-search-forward

bind -M insert ctrl-j history-token-search-forward
bind -M insert ctrl-k history-token-search-backward
bind -M insert ctrl-l 'commandline -f ([ "$(commandline)" = "" ] && echo clear-screen || echo forward-word)'

bind -M insert alt-h backward-char
bind -M insert alt-j down-or-search
bind -M insert alt-k up-or-search
bind -M insert alt-l forward-char
