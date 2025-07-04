function revanced -d "patch and install apks with revanced" -a apkid
    set -f update_url
    switch apkid
        case ch.protonmail.android
        case com.bandcamp.android
        case com.crunchyroll.crunchyroid
        case com.duolingo
        case com.facebook.katana
            set update_url "https://www.apkmirror.com/apk/facebook-2/facebook/facebook-%s-release/facebook-%s-android-apk-download/"
        case com.facebook.orca
        case com.google.android.apps.magazines
        case com.google.android.apps.photos
        case com.google.android.apps.recorder
        case com.google.android.apps.youtube.music
            set update_url "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-%s-release/youtube-music-%s-android-apk-download/"
        case com.google.android.youtube
            set update_url "https://www.apkmirror.com/apk/google-inc/youtube/youtube-%s-release/youtube-%s-android-apk-download/"
        case com.instagram.android
        case com.instagram.barcelona
        case com.microblink.photomath
        case com.soundcloud.android
        case com.spotify.music
        case com.twitter.android
        case jp.pxv.android
        case ml.docilealligator.infinityforreddit
        case ml.docilealligator.infinityforreddit.patreon
        case ml.docilealligator.infinityforreddit.plus
        case tv.twitch.android.app
    end

    cd ~/Downloads/main/revanced || return

    [ (math (date +%s) - (stat -c '%Y' -- api.json)) -gt 3600 ]
    and curl -o api.json -#LH "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/revanced/revanced-patches/releases/latest

    set patchname (jq -r .assets[0].name api.json)
    set patchurl (jq -r .assets[0].browser_download_url api.json)
    command -vq glow
    and jq -r .body api.json | sed -r 's/\(.*\)\r$//' | glow
    or jq -r .body api.json | sed -r 's/\(.*\)\r$//'
    [ -e "$patchname" ] || curl -#Lo "$patchname" "$patchurl"
    set apkversion (revanced-cli list-patches -pvf "$apkid" "$patchname" | rg '^\t\t\d+(\.\d+)+$' | sort -g | tail -n1)

    if not [ -e {$apkid}_{$apkversion}.apk ]
        set apkverdash (printf "$apkversion" | tr . -)
        printf "pls download the latest apk file and move it to `$apkid"_"$apkversion.apk`\n"
        [ -n "$update_url" ]
        and open (printf "$update_url" "$apkverdash" "$apkverdash")
        or open "https://www.apkmirror.com/?post_type=app_release&searchtype=app&s=$apkid"
        return
    end

    [ -e "revanced.keystore" ] || return
    set -e DISPLAY # DISPLAY breaks decoding resourses
    [ (count (adb devices)) -gt 2 ] && set adb -i

    revanced-cli patch -p "$patchname" {$apkid}_{$apkversion}.apk --keystore revanced.keystore \
        --enable "Custom branding" --enable Theme -OdarkThemeBackgroundColor=#FF24283B $adb

    rm -rf *-patched-temporary-files
end
