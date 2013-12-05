dns_role() {
  tmpl hostname /etc/hostname dns && \
  tmpl hosts /etc/hosts
}
