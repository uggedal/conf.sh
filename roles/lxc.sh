lxc_role() {
  pkg add lxc && \
    tmpl lxc.default.conf /etc/lxc/default.conf
}
