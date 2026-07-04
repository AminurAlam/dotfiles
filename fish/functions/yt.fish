function yt -a url fmt -d "yt-dlp wrapper"
    # TODO: auto create tmux session
    function tname
        [ -n "$TMUX" ] && tmux rename-window -t $TMUX_PANE $argv[1]
    end

    [ -z "$url" ] && set url (wl-paste)

    if not set -q TERMUX_VERSION && [ -d "$XDG_CONFIG_HOME/librewolf/librewolf/" ]
        set -f cookies --cookies-from-browser "firefox:$XDG_CONFIG_HOME/librewolf/librewolf/"
    end

    # strip playlist params
    set url (printf '%s' "$url" | sed -r 's/&list=.*$//')

    # pick and choose if no fmt given
    if [ -z "$fmt" ]
        mkdir -p $XDG_VIDEOS_DIR/yt/fmtcache/

        set fmtfile $XDG_VIDEOS_DIR/yt/fmtcache/(
            echo "$url" \
            | tr -dc \[:alnum:\]_- \
            | sed -E 's/^https(wwwyoutubecomwatchv|youtubecomwatchv|youtube)(.{11}).*/\2/').json

        tname fetching
        [ -e "$fmtfile" ] || yt-dlp $cookies -js "$url" >$fmtfile

        if [ "$(du $fmtfile | kt 1)" = 0 ]
            rm $fmtfile
            return 2
        end

        set -f title (jq -r '.filename' $fmtfile | path basename)

        tname pick
        set -f fmt (
            cat $fmtfile \
            | jq -rf ~/repos/dotfiles/scripts/yt.jq \
            | column -ts\t \
            | fzf --tac --header "$title" \
            | kt 1
        )

        [ -z "$fmt" ] && return 2
    end

    if [ "$(jq -r .extractor $fmtfile)" = youtube ]
        set afmt (
            jq -r '.formats[] \
            | select(.format_note and (.format_note | contains("original"))) \
            | .format_id' $fmtfile \
            | head -n1
        )
        [ -z "$afmt" ] && set afmt bestaudio
        set fmt "$fmt+$afmt"
    end

    tname downloading
    clear
    echo "$title"
    yt-dlp $cookies -f "$fmt" -- "$url"
    and tname done
    or tname error
end
