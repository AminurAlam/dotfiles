status is-interactive || exit

fish_vi_key_bindings

bind yy fish_clipboard_copy # TODO: only copy a line not entire block
bind p fish_clipboard_paste

bind q exit # shortcuts to quit
bind -M insert ctrl-\; "history -n1 | fish -P; commandline -f repaint"
bind -M insert ctrl-z 'if jobs -q; fg; else; mux; end' # helpful for toggling between stuff
bind -M insert ctrl-v backward-kill-bigword # delete from whitespace to cursor
bind -M insert ctrl-backspace backward-kill-bigword
bind -M insert ctrl-d exit

# search current token in history
bind -M insert ctrl-up history-token-search-backward
bind -M insert ctrl-down history-token-search-forward

bind -M insert ctrl-n complete
bind -M insert ctrl-p complete-and-search

bind -M insert ctrl-j history-token-search-forward
bind -M insert ctrl-k history-token-search-backward
bind -M insert ctrl-l 'commandline -f ([ "$(commandline)" = "" ] && echo clear-screen || echo forward-word)'

bind -M insert alt-h backward-char
bind -M insert alt-j down-or-search
bind -M insert alt-k up-or-search
bind -M insert alt-l forward-char

### autopair
# https://github.com/jorgebucaran/autopair.fish

set --global autopair_left \( \[ \{ \" \'
set --global autopair_right \) \] \} \" \'
set --global autopair_pairs "()" "[]" "{}" '""' "''"

set --query fish_key_bindings[1] || return

test $fish_key_bindings = fish_default_key_bindings &&
    set --local mode default insert ||
    set --local mode insert default

bind --mode $mode[-1] --erase \177 \b \t

bind --mode $mode[1] \177 _autopair_backspace # macOS ⌫
bind --mode $mode[1] \b _autopair_backspace
bind --mode $mode[1] \t _autopair_tab

printf "%s\n" $autopair_pairs | while read --local left right --delimiter ""
    bind --mode $mode[-1] --erase $left $right
    if test $left = $right
        bind --mode $mode[1] $left "_autopair_insert_same \\$left"
    else
        bind --mode $mode[1] $left "_autopair_insert_left \\$left \\$right"
        bind --mode $mode[1] $right "_autopair_insert_right \\$right"
    end
end
