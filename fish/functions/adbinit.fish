function adbinit -d "configure adb  settings with just one command"
    set -f ANDROID_USER_HOME "$XDG_DATA_HOME"/.android
    set -f HOME "$XDG_DATA_HOME"

    set -f shizuku_brick /data/app/~~etCozTSLM3kcAbBcIlHcAA==/moe.shizuku.privileged.api-nNcoNJh_25G1e6HU-CAVvg==/lib/arm64/libshizuku.so
    set -f shizuku_slab /data/app/moe.shizuku.privileged.api-yHnca5Z0ZGnjNHnoRloPVw==/lib/arm64/libshizuku.so
    set -f shizuku_paper /data/app/~~q0JQnInP8rrYIV-QzPLJ-A==/moe.shizuku.privileged.api-7JrKGm3mrKQo4YIK9ElV-A==/lib/arm64/libshizuku.so
    set -f settings icon_blacklist bluetooth,nfc,power_saver,rotate,volte,ims_volte,ims_volte2,volume,wifi_calling,bluetooth_connected,mute,right_clock_position

    adb wait-for-device
    adb -d shell $shizuku_brick
    adb -d shell $shizuku_slab
    adb -d shell $shizuku_paper
    adb -d shell settings put secure $settings
    adb tcpip 5555
    adb connect (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1)
    adb -e shell $shizuku_brick
    adb -e shell $shizuku_slab
    adb -e shell $shizuku_paper
    adb -e shell settings put secure $settings
end
