function pkglist -d "script for updating \$CONF/setup/list/* files"
    [ (type -t adb) = function ] || return
    adb init
    set pkglist "$HOME/repos/dotfiles/setup/pkglist"

    pacman -Qqe >"$pkglist/arch-pacman"
    uv tool list >"$pkglist/arch-uv"
    ssh brick pacman -Qqe >"$pkglist/termux-pacman"
    ls $CARGO_HOME/bin/ >"$pkglist/arch-cargo"
    adb shell pm list packages -i -3 | kt : 2 | kt 2 1 | sort >"$pkglist/android-3rd"
    adb shell pm list packages -d | kt : 2 | sort >"$pkglist/android-disabled"

    ### interactively uninstall/disable apps
    # adb shell pm list packages | kt : 2 | fzf --bind 'enter:execute(env ANDROID_USER_HOME=$XDG_DATA_HOME/.android HOME=$XDG_DATA_HOME adb uninstall --user 0 {} || env ANDROID_USER_HOME=$XDG_DATA_HOME/.android HOME=$XDG_DATA_HOME adb shell pm disable-user --user 0 {} || sleep 1)'

    ### apply disabled apps list
    # set currently_disabled (mktemp -t disabled-XXXXX)
    # adb shell pm list packages -d | kt : 2 >"$currently_disabled"
    # for app in (cat ~/repos/dotfiles/setup/pkglist/android-disabled)
    #     rg -qF "$app" $currently_disabled
    #     or adb shell pm disable-user "$app" --user 0
    # end
end
