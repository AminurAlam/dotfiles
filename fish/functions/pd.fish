function pd

    command -sq proot-distro || begin
        printf "proot-distro is not installed\n"
        return
    end

    set -l distros alpine archlinux debian fedora manjaro-aarch64 opensuse pardus ubuntu void
    set -l distro $argv[1]
    set -l distro (string replace manjaro-aarch64 manjaro $distro)
    set -l distro (string replace archlinux       arch    $distro)
    set -l distro (string replace opensuse        suse    $distro)

    switch $distro
        case $distros
            proot-distro login $distro || begin
                read install -fP "cant login to %s, try installing it? [y/N] " "$distro"
                [ $install = y ] && proot-distro install $distro
            end
        case "*"
            printf "%s is not a supported distro\n" "$distro"
            return
    end

end
