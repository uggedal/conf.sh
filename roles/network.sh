network_role() {
  tmpl hostname /etc/hostname &&
    daemon enable dhcpcd
}
