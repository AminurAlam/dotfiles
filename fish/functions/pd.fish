function pd

    command -sq proot-distro || begin
        printf "proot-distro is not installed\n"
        return
    end

    set -l distros   alpine archlinux debian fedora manjaro-aarch64 opensuse pardus ubuntu void
    set -l distro $argv[1]

    string replace manjaro manjaro-aarch64 $distro
    string replace arch    archlinux       $distro
    string replace suse    opensuse        $distro

    switch $distro
        case $distros
            proot-distro login $distro
            or read install -fP "cant login to %s, try installing it? [y/N] "
            [ $install = "y" ] && proot-distro install $distro
        case "*"
            printf "$distro is not a supported distro\n"
            return
    end

end
