syslog_role() {
  pkg add socklog-void &&
    daemon enable nanoklogd &&
    daemon enable socklog-unix
}
