function revanced -d "patch and install apks with revanced" -a apkid
    switch $apkid
        case at.willhaben
        case ch.protonmail.android
        case ch.protonvpn.android
        case com.adobe.lrmobile
        case com.amazon.avod.thirdpartyclient
        case com.amazon.mShop.android.shopping
        case com.bandcamp.android
        case com.cricbuzz.android
        case com.crunchyroll.crunchyroid
        case com.disney.disneyplus
        case com.drinkplusplus.angulus
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
            set update_url "https://www.apkmirror.com/apk/google-inc/youtube/youtube-%s-release/youtube-%s-2-android-apk-download/"
        case com.instagram.android
        case com.instagram.barcelona
        case com.letterboxd.letterboxd
        case com.microblink.photomath
        case com.myfitnesspal.android
        case com.myprog.hexedit
        case com.nis.app
        case com.nousguide.android.orftvthek
        case com.rarlab.rar
        case com.sec.android.app.fm
        case com.sony.songpal.mdr
        case com.soundcloud.android
        case com.spotify.music
        case com.ss.android.ugc.trill
        case com.strava
        case com.swisssign.swissid.mobile
        case com.ticktick.task
        case com.tumblr
        case com.viber.voip
        case com.xiaomi.wearable
        case com.zhiliaoapp.musically
        case com.zombodroid.MemeGenerator
        case eu.faircode.netguard
        case ginlemon.iconpackstudio
        case in.startv.hotstar
        case in.startv.hotstaronly
        case io.syncapps.lemmy_sync
        case jp.pxv.android
        case net.binarymode.android.irplus
        case nl.sanomamedia.android.nu
        case org.totschnig.myexpenses
        case pl.solidexplorer2
        case tv.trakt.trakt
    end

    cd ~/dl/main/revanced || return 1

    set patchname /usr/share/revanced/revanced-patches-bin.rvp
    [ -e "$patchname" ] || return 2
    set apkversion (
        revanced-cli list-versions -b --patches "$patchname" --filter-package-names "$apkid" \
        | rg '^\t' \
        | sort -rn \
        | fzf --bind "one:accept" \
        | kt 1 \
        | string trim)

    if [ "$apkversion" = Any ]
        set apkfile (fd -1 -d1 -tf --glob {$apkid}_\*.apk)
    else
        set apkfile {$apkid}_{$apkversion}.apk
    end

    if not [ -e "$apkfile" ]
        set apkverdash (printf "$apkversion" | tr . -)
        printf "pls download the latest apk file and move it to `$apkid"_"$apkversion.apk`\n"
        [ -n "$update_url" ]
        and open (printf "$update_url" "$apkverdash" "$apkverdash")
        or open "https://www.apkmirror.com/?post_type=app_release&searchtype=app&s=$apkid"
        return
    end

    [ -e "revanced.keystore" ] || return 3
    set -e DISPLAY # DISPLAY breaks decoding resourses

    revanced-cli patch -b --patches "$patchname" "$apkfile" --keystore revanced.keystore \
        --enable "Custom branding" --enable Theme -OdarkThemeBackgroundColor=#FF24283B --enable "Disable signature check"

    rm -rf *-patched-temporary-files
end
