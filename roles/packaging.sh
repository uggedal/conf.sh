packaging_role() {
  pkg add strace gdb

  tmpl xbps.xbps-src.conf /etc/xbps/xbps-src.conf
}
