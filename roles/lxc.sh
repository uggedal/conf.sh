lxc_role() {
  pkg add lxc lxc-templates && \
    tmpl lxc.default.conf /etc/lxc/default.conf
}
