function battery

	set old (termux-battery-status | jq .current)

	while [ ! ]
		set new (termux-battery-status | jq .current)
		# [ $new -lt -500 ] && set color (set_color red)
		[ $new -lt 0 ] && set color (set_color red)
		[ $new -gt 0 ] && set color (set_color grey)
		[ $new -gt 500 ] && set color (set_color yellow)
		[ $new -gt 800 ] && set color (set_color green)
		[ $new -gt 1000 ] && set color (set_color cyan)

		if [ $old -ne $new ]
			for n in (seq (math "round($COLUMNS*(abs($new)/1400))"))
				echo -n "$color█"
			end
			echo (set_color normal) " $new"
			set old $new
		end
	end

end
