ntpd_role() {
  daemon enable ntpd && \
    daemon start ntpd
}
