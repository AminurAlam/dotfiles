function bm
    set HELP_TEXT "usage:
    bm <f|fd|find> [query]  find something with fuzzy search
    bm <g|get> /regex/      list entries with matching regex pattern
    bm <a|add> <text>       add a new entry
    bm <e|ed|edit>          edit the entries"

    # you can add more paths here
    set -q BMPATH || set -g BMPATH $HOME/.config/bookmarks

    function _bm_find
        set -l colors "dark,fg:,bg:,matched:,matched_bg:#364A82,current:#7dcfff,current_bg:,current_match:#1d202f,current_match_bg:#ff9e64,query:,query_bg:,info:,border:#c0caf5,prompt:,pointer:,marker:,spinner:,header:"
        set -l opts --prompt '  ' --inline-info --no-multi --margin 0,3,1,3 --border
        set -l FZF_DEFAULT_OPTS $opts
        set -l SKIM_DEFAULT_OPTIONS $opts --color $colors --header (printf '─%.0s' (seq $COLUMNS) )

        if command -sq fzf;       set ff fzf $FZF_DEFAULT_OPTS
        else if command -sq sk;   set ff sk $SKIM_DEFAULT_OPTIONS
        else if command -sq fzy;  set ff fzy
        else if command -sq pick; set ff pick
        else; echo "skim, fzf, fzy, pick not installed" && return 1
        end

        set LINK (
            cat "$BMPATH" |
            grep '^http' |
            uniq |
            sed --regexp-extended 's#^https?://(www.)?##' |
            $ff --query "$argv"
        )

        [ -n "$LINK" ] && xdg-open "https://$LINK" || echo "nothing selected"
    end

    function _bm_get
        grep -i --no-filename "$argv" "$BMPATH"
    end

    function _bm_add
        touch "$BMPATH"
        [ -n "$argv" ] && echo "$argv" >> "$BMPATH" || echo "nothing to add"
    end

    function _bm_edit
        set -q EDITOR && $EDITOR $BMPATH || echo "no EDITOR found" && return 1
    end

    switch "$argv[1]"
        case f fd find; _bm_find $argv[2]
        case g get; _bm_get $argv[2]
        case a add; _bm_add $argv[2]
        case e ed edit; _bm_edit
        case '*'; echo $HELP_TEXT
    end
end
