function adb -d "adb wrapper"
    set -f ANDROID_USER_HOME "$XDG_DATA_HOME"/.android
    set -f HOME "$XDG_DATA_HOME"

    if [ "$argv[1]" = init ]
        set ip (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1)

        if [ -n "$ip" ]
            command adb -d tcpip 5555

            command adb connect "$ip"
            command adb connect android.local
            and command adb disconnect "$ip"
        end

        command adb devices

        for n in 1 3 4 6
            # adb reverse tcp:1000$n tcp:1000$n
        end

        # set -f shizuku_lib (command adb -e shell pm path moe.shizuku.privileged.api | sed -E 's#^package:(.*)/base.apk$#\1/lib/arm64/libshizuku.so#')
        # [ -n "$shizuku_lib" ] && command adb -e shell $shizuku_lib
        # command adb -e shell settings put secure icon_blacklist rotate,headset,fuseboxon,rotate,headset,ims_volte,ims_volte2,volume,mute
        command adb -e shell settings put secure multi_audio_focus_enabled 0
        command adb -e shell settings put secure sysui_quick_bar_collapsed_row 3
        command adb -e shell settings put system adjust_media_volume_only 1
    else
        command adb $argv
    end

    rm -fr /home/fisher/.android/
end
