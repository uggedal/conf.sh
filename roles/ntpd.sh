ntpd_role() {
  pkg add busybox-ntpd &&
    daemon enable busybox-ntpd
}
