status is-interactive || exit
fish --version | tr -dc [:digit:] | grep -q ^4 || exit

fish_vi_key_bindings

bind yy fish_clipboard_copy
bind p fish_clipboard_paste
bind -M insert ctrl-b mux

bind q exit # shortcuts to quit
bind r redo # replace -> redo
bind -M insert ctrl-z 'jobs -q && fg' # helpful for toggling between processes
bind -M insert ctrl-v backward-kill-bigword # delete from whitespace to cursor
bind -M insert ctrl-d 'set -q TMUX && tmux detach || exit'

# search current token in history
bind -M insert ctrl-up history-token-search-backward
bind -M insert ctrl-down history-token-search-forward

bind -M insert ctrl-j history-token-search-forward
bind -M insert ctrl-k history-token-search-backward
bind -M insert alt-j down-or-search
bind -M insert alt-k up-or-search
