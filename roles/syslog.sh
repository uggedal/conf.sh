syslog_role() {
  pkg add rsyslog &&
    daemon enable rsyslogd
}
