function adbinit -d "configure adb  settings with just one command"
    set -f ANDROID_USER_HOME "$XDG_DATA_HOME"/.android
    set -f HOME "$XDG_DATA_HOME"

    adb -d wait-for-device

    set -f shizuku_lib (adb -d shell pm path moe.shizuku.privileged.api | sed -E 's#^package:(.*)/base.apk$#\1/lib/arm64/libshizuku.so#')
    # set -f settings icon_blacklist rotate,headset,fuseboxon,rotate,headset,ims_volte,ims_volte2,volume,mute,right_clock_position

    [ -n "$shizuku_lib" ] && adb -d shell $shizuku_lib
    # adb -d shell settings put secure $settings

    adb -d tcpip 5555
    adb -d connect (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1)
    [ -n "$shizuku_lib" ] && adb -e shell $shizuku_lib
    # adb -e shell settings put secure $settings
end
