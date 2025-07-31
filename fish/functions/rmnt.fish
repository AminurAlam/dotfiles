function rmnt
    # sshfs -o reconnect phone:/sdcard/ /mnt/phone/
    # sshfs -o reconnect phone: /mnt/termux/
    set remote (rclone listremotes | sed 's/:$//' | fzf)

    [ -z "$remote" ] && return 4
    [ -d "/mnt/$remote" ] || sudo mkdir -p /mnt/$remote
    [ -O "/mnt/$remote" ] || sudo chown -R fisher /mnt/$remote

    rclone mount $remote: /mnt/$remote --daemon
    # y /mnt/$remote/
    builtin cd /mnt/$remote/
    wl-copy "fusermount -u /mnt/$remote"
end
