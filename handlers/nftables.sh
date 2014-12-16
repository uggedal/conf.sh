nftables_handler() {
  local _ t c

  local chain_re='^[[:blank:]]+chain [[:alnum:]]+ {$'

  nft list tables inet | while read _ t; do
    nft flush table inet $t
    nft delete table inet $t
  done

  nft -f /etc/nftables.conf
}
