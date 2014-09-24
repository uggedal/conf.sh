network_role() {
  tmpl -s /etc/hostname &&
    daemon enable dhcpcd
}
