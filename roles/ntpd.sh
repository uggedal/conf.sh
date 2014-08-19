ntpd_role() {
  pkg add ntp &&
    daemon enable ntpd
}
