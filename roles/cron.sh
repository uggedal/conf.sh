cron_role() {
  pkg add dcron &&
    daemon enable dcron
}
