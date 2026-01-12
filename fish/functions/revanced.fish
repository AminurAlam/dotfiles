function revanced -d "patch and install apks with revanced" -a apkid
    switch $apkid
        case at.gv.bka.serviceportal
        case at.gv.bmf.bmf2go
        case at.gv.oe.app
        case at.willhaben
        case ch.protonmail.android
        case ch.protonvpn.android
        case com.adobe.lrmobile
        case com.amazon.avod.thirdpartyclient
        case com.amazon.mShop.android.shopping
        case com.andrewshu.android.reddit
        case com.andrewshu.android.redditdonation
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
        case com.laurencedawson.reddit_sync
        case com.laurencedawson.reddit_sync.dev
        case com.laurencedawson.reddit_sync.pro
        case com.letterboxd.letterboxd
        case com.microblink.photomath
        case com.myfitnesspal.android
        case com.myprog.hexedit
        case com.nis.app
        case com.nousguide.android.orftvthek
        case com.onelouder.baconreader
        case com.onelouder.baconreader.premium
        case com.pandora.android
        case com.peacocktv.peacockandroid
        case com.piccomaeurope.fr
        case com.rarlab.rar
        case com.reddit.frontpage
        case com.rubenmayayo.reddit
        case com.sec.android.app.fm
        case com.sony.songpal.mdr
        case com.soundcloud.android
        case com.spotify.music
        case com.ss.android.ugc.trill
        case com.strava
        case com.swisssign.swissid.mobile
        case com.ticktick.task
        case com.tumblr
        case com.twitter.android
        case com.viber.voip
        case com.xiaomi.wearable
        case com.zhiliaoapp.musically
        case com.zombodroid.MemeGenerator
        case de.dwd.warnapp
        case de.simon.openinghours
        case de.stocard.stocard
        case de.tudortmund.app
        case eu.faircode.netguard
        case free.reddit.news
        case ginlemon.iconpackstudio
        case in.startv.hotstar
        case in.startv.hotstaronly
        case io.syncapps.lemmy_sync
        case it.ipzs.cieid
        case jp.pxv.android
        case me.ccrama.redditslide
        case ml.docilealligator.infinityforreddit
        case ml.docilealligator.infinityforreddit.patreon
        case ml.docilealligator.infinityforreddit.plus
        case net.binarymode.android.irplus
        case nl.sanomamedia.android.nu
        case o.o.joey
        case o.o.joey.dev
        case o.o.joey.pro
        case org.totschnig.myexpenses
        case pl.solidexplorer2
        case reddit.news
        case tv.trakt.trakt
        case tv.twitch.android.app
    end

    cd ~/Downloads/main/revanced || return

    if not [ -e api.json ] || [ (math (date +%s) - (stat -c '%Y' -- api.json)) -gt 3600 ]
        curl -o api.json -#LH "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            https://api.github.com/repos/revanced/revanced-patches/releases/latest
    end

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
        --enable "Custom branding" --enable Theme -OdarkThemeBackgroundColor=#FF24283B --enable "Disable signature check" $adb

    rm -rf *-patched-temporary-files
end
