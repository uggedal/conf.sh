lxc_role() {
  pkg add lxc &&
    tmpl -s /etc/lxc/default.conf
}
