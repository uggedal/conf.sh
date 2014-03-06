base_role() {
  pkg world \
    app-editors/vim

  tmpl inputrc /etc/inputrc

  pkg select editor /usr/bin/vi

  if fgrep -q btrfs /etc/fstab; then
    pkg world sys-fs/btrfs-progs
  fi
}
