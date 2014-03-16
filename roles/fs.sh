fs_role() {

  awk '{ print $3 }' /etc/fstab | grep -q '^btrfs$' && pkg add btrfs-progs
}
