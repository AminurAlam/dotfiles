function pd -a distro
    command -vq proot-distro || pacman -S proot-distro || return

    [ -z "$distro" ] && begin
        set -f awkscript
        proot-distro list 2>&1 | awk '{
            if ($0 ~ /  .*Alias:/) printf("%s ", $2);
            if ($0 ~ /  .*Installed:/) printf(" %s\n", $2);
        }'
    end && return

    # NOTE: keep this list updated
    set -l distros alpine archlinux artix debian debian-oldstable deepin fedora manjaro openkylin opensuse pardus ubuntu ubuntu-lts ubuntu-oldlts void

    set distro (string replace arch archlinux $distro)
    set distro (string replace suse opensuse  $distro)

    switch $distro
        case $distros
            proot-distro login --isolated --shared-tmp "$distro"
        case "i*"
            proot-distro install "$distro"
        case "*"
            printf "%s is not a supported distro\n" "$distro"
            return
    end

end
