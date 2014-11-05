pkgupdate_role() {
  local daily=/etc/cron.daily/pkgupdate

  inode file $daily 740 &&
    file pkgupdate.sh $daily
}
