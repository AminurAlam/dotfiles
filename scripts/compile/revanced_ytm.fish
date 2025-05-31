set DEPENDENCIES jq android-tools
set apkid com.google.android.apps.youtube.music
set update_url "https://www.apkmirror.com/apk/google-inc/youtube-music/youtube-music-%s-release/youtube-music-%s-android-apk-download/"

function pre_build
    command -vq jq || yay -S --needed $DEPENDENCIES

    cd ~/Downloads/revanced
    curl -o api.json -#LH "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/revanced/revanced-patches/releases/latest
    set patchname (jq -r .assets[0].name api.json)
    set patchurl (jq -r .assets[0].browser_download_url api.json)

    jq -r .body api.json

    [ -e "$patchname" ] || curl -#Lo "$patchname" "$patchurl"
    ln -fs "$patchname" patch.rvp

    set apkversion (revanced-cli list-patches -pvf "$apkid" patch.rvp \
        | rg '^\t\t\d+\.\d+\.\d+$' | sort -g | tail -n1)
    [ -e "$apkid"_"$apkversion.apk" ] || begin
        set apkverdash (printf "$apkversion" | tr . -)
        printf "pls download the latest apk file and move it to `$apkid"_"$apkversion.apk`\n"
        open (printf "$update_url" "$apkverdash" "$apkverdash")
        exit
    end
    ln -fs "$apkid"_"$apkversion.apk" temp.apk

    [ -e "revanced.keystore" ] || exit
end

function build
    cd ~/Downloads/revanced
    set -e DISPLAY # DISPLAY breaks decoding resourses
    [ (count (adb devices)) -gt 2 ] && set adb -i

    revanced-cli patch -p patch.rvp temp.apk --keystore revanced.keystore \
        --enable "Custom branding" --enable Theme -OdarkThemeBackgroundColor=#FF24283B $adb
end

function post_build
    unlink patch.rvp
    unlink temp.apk
    rm -rf *-patched-temporary-files api.json
end

pre_build

build

post_build
