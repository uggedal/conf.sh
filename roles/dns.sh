dns_role() {
  tmpl hosts /etc/hosts && \
  tmpl hostname.confd /etc/conf.d/hostname dns
}
