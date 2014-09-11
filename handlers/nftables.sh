nftables_handler() {
  local _ t c

  local chain_re='^[[:blank:]]+chain [[:alnum:]]+ {$'

  nft list tables inet | while read _ t; do
    nft flush table inet $t
    nft list table inet $t | awk "/$chain_re/ { print \$2 }" | while read c; do
      nft flush chain inet $t $c
      nft delete chain inet $t $c
    done
    nft delete table inet $t
  done

  nft -f /etc/nftables.conf
}
