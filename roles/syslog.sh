syslog_role() {
  pkg add rsyslog &&
    inode link /etc/sv/rsyslogd /var/service/rsyslogd
}
