# script for updating setup/list/* files

function pm
    set -f ANDROID_USER_HOME "$XDG_DATA_HOME"/.android
    set -f HOME "$XDG_DATA_HOME"

    adb shell pm $argv
end

set pkglist "$HOME/repos/dotfiles/setup/pkglist"

pacman -Qqe >"$pkglist/arch-pacman"

ssh brick pacman -Qqe >"$pkglist/termux-pacman"

pm list packages -i -3 | kt : 2 | kt 2 1 | sort >"$pkglist/android-3rd"

pm list packages -d | kt : 2 | sort >"$pkglist/android-disabled"

### interactively disable apps
# pm list packages -s | kt : 2 | fzf --bind 'enter:execute(pm disable-user --user 0 {} || sleep 1)'

### apply disabled apps list
# set currently_disabled (mktemp -t disabled-XXXXX)
# pm list packages -d | kt : 2 >"$currently_disabled"
# for app in (cat ~/repos/dotfiles/setup/pkglist/android-disabled)
#     rg -qF "$app" $currently_disabled
#     or pm disable-user "$app" --user 0
# end
