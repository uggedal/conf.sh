locale_role() {
  tmpl -s /etc/locale.conf &&
    tmpl -s /etc/default/libc-locales -h locale
}
