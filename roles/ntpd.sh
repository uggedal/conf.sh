ntpd_role() {
  pkg world net-misc/openntpd && \
    tmpl ntpd.confd /etc/conf.d/ntpd ntpd && \
    daemon enable ntpd
}
