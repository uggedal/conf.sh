ntpd_role() {
  pkg openntpd && \

  tmpl ntpd.confd /etc/conf.d/ntpd ntpd
}
