rc_role() {
  tmpl rc.conf /etc/rc.conf &&
    tmpl rc.local /etc/rc.local
}
