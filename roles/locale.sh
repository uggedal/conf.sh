locale_role() {
  tmpl locale.conf /etc/locale.conf &&
    tmpl default.libc-locales /etc/default/libc-locales locale
}
