nftables_role() {
  pkg add nftables &&
    tmpl nftables.conf /etc/nftables.conf nftables
}
