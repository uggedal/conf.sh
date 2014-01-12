syslog_role() {
  pkg world app-admin/sysklogd && \
  daemon enable sysklogd
}
