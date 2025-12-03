function adbinit -d "adb stuff"
    ANDROID_USER_HOME="$XDG_DATA_HOME"/.android HOME="$XDG_DATA_HOME" begin
        set shizuku /data/app/~~etCozTSLM3kcAbBcIlHcAA==/moe.shizuku.privileged.api-nNcoNJh_25G1e6HU-CAVvg==/lib/arm64/libshizuku.so
        set settings icon_blacklist bluetooth,nfc,power_saver,rotate,volte,ims_volte,ims_volte2,volume,wifi_calling,bluetooth_connected,mute,right_clock_position

        adb wait-for-device
        adb -d shell $shizuku
        adb -d shell settings put secure $settings
        adb tcpip 5555
        adb connect (route -n | awk '/^[0.]+/{print $2}' | uniq | head -n1)
        adb -e shell $shizuku
        adb -e shell settings put secure $settings
    end
end
