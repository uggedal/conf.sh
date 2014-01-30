shell_role() {
  pkg world app-shells/dash

  [ -x /bin/dash ] && \
    [ /bin/dash != "$(readlink -f /bin/sh)" ] && \
    ln -sf /bin/dash /bin/sh

  tmpl inputrc /etc/inputrc
}
