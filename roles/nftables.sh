nftables_role() {
  pkg add nftables &&
    tmpl -s /etc/nftables.conf -h nftables
}
