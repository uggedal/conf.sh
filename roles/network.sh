network_role() {
  tmpl hostname /etc/hostname &&
    inode link /etc/sv/dhcpcd /var/service/dhcpcd
}
