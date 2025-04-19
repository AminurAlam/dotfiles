function pd -a distro -d "proot-distro wrapper"
    command -vq proot-distro || pacman -S proot-distro || return

    [ -z "$distro" ] && begin
        set -f awkscript
        proot-distro list 2>&1 | awk '{
            if ($0 ~ /  .*Alias:/) printf("%s ", $2);
            if ($0 ~ /  .*Installed:/) printf(" %s\n", $2);
        }'
    end && return

    set -l distros alpine archlinux artix chimera debian debian-oldstable deepin fedora manjaro openkylin opensuse pardus ubuntu ubuntu-oldlts void

    set distro (string replace arch archlinux $distro)
    set distro (string replace suse opensuse  $distro)

    switch $distro
        case $distros
            proot-distro login --shared-tmp "$distro" $argv[2..]
        case "i*"
            proot-distro install "$distro"
        case "*"
            printf "%s is not a supported distro\n" "$distro"
            return
    end

end
