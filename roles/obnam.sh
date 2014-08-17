obnam_role() {
  local conf=/etc/obnam.conf
  local hourly=/etc/cron.hourly/obnam
  local daily=/etc/cron.daily/obnam

  pkg add obnam &&
    inode dir /var/log/obnam 750 &&
    inode file $conf 640 &&
    inode file $hourly 740 &&
    inode file $daily 740 &&
    tmpl obnam.conf $conf &&
    tmpl cron.hourly.obnam $hourly &&
    tmpl cron.daily.obnam $daily &&
    tmpl logrotate.d.obnam /etc/logrotate.d/obnam
}
