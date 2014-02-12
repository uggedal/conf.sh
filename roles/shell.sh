shell_role() {
  [ -x /bin/bb ] && \
    [ /bin/bb != "$(readlink -f /bin/sh)" ] && \
    ln -sf /bin/bb /bin/sh

  tmpl inputrc /etc/inputrc
}
