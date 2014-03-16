syslog_role() {
  daemon enable syslog && \
    daemon start syslog
}
