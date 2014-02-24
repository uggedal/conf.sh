syslog_role() {
  daemon enable busybox-klogd && \
  daemon enable busybox-syslogd
}
