set DEPENDENCIES jq android-tools

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

    set apkversion (revanced-cli list-patches -pvf com.google.android.youtube patch.rvp \
        | rg '^\t\t\d+\.\d+\.\d+$' | sort -g | tail -n1)
    # https://www.apkmirror.com/?post_type=app_release&searchtype=apk&s=youtube+$apkversion
    [ -e "youtube_$apkversion.apk" ] || begin
        open "https://www.apkmirror.com/apk/google-inc/youtube/youtube-$(printf "$apkversion" | tr . -)-release/youtube-$(printf "$apkversion" | tr . -)-android-apk-download/"
        printf "pls download the latest apk file and move it to `youtube_$apkversion.apk`\n"
        exit
    end
    ln -fs "youtube_$apkversion.apk" yt.apk

    [ -e "yt.keystore" ] || exit
end

function build
    cd ~/Downloads/revanced
    set -e DISPLAY # DISPLAY breaks decoding resourses
    [ (count (adb devices)) -gt 2 ] && set adb -i

    revanced-cli patch -p patch.rvp yt.apk --keystore yt.keystore \
        --enable "Custom branding" --enable Theme -OdarkThemeBackgroundColor=#FF24283B $adb
end

function post_build
    unlink patch.rvp
    unlink yt.apk
    rm -rf *-patched-temporary-files api.json
end

pre_build

build

post_build
