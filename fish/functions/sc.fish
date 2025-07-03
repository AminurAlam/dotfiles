function sc -d "scrcpy wrapper"
    adb wait-for-device
    if not adb devices | rg -q '^192\.168.*device$'
        adb tcpip 5555
        adb connect (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1) || return
        sleep 1
    end

    switch "$argv[1]"
        case -
            scrcpy -eS -b 15M --max-fps 30 & disown
        case 5g
            scrcpy --crop=160:124:845:20 --no-audio -n -b 2M --window-title 5g & disown
        case cam
            scrcpy -e --video-source camera --camera-id 0 --camera-ar sensor -b 25M & disown
        case v4l
            sudo modprobe v4l2loopback
            scrcpy -e --video-source camera --camera-id 0 --camera-ar sensor --v4l2-sink /dev/video2 -N & disown
        case "*"
            set app (scrcpy -e --list-apps 2>/dev/null | rg --replace '' '^ (\*|-) ' | fzf -q "$argv[1]" | awk '{print $NF}')
            [ -z "$app" ]
            and scrcpy -eS -b 15M --max-fps 30 & disown
            or scrcpy -eS -b 15M --max-fps 30 --new-display=960x1045/200 --no-vd-destroy-content --start-app "$app" & disown
    end
end
