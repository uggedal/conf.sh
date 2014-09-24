rc_role() {
  tmpl -s /etc/rc.conf &&
    tmpl -s /etc/rc.local
}
