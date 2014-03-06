base_role() {
  pkg world \
    app-editors/vim

  tmpl inputrc /etc/inputrc

  pkg select editor /usr/bin/vi

  fgrep -q btrfs /etc/fstab && pkg world sys-fs/btrfs-progs
}
