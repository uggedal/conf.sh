obnam_role() {
  local conf=/etc/obnam.conf
  local hourly=/etc/cron.hourly/obnam
  local daily=/etc/cron.daily/obnam

  pkg add obnam &&
    inode dir /var/log/obnam 750 &&
    inode file $conf 640 &&
    inode file $hourly 740 &&
    inode file $daily 740 &&
    tmpl -s $conf &&
    tmpl -s $hourly &&
    tmpl -s $daily &&
    tmpl -s /etc/logrotate.d/obnam
}
