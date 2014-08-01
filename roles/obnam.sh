obnam_role() {
  local conf=/etc/obnam.conf
  local hourly=/etc/periodic/hourly/obnam
  local daily=/etc/periodic/daily/obnam

  pkg add obnam &&
    inode dir /var/log/obnam 750 &&
    inode file $conf 640 &&
    inode file $hourly 740 &&
    inode file $daily 740 &&
    tmpl obnam.conf $conf &&
    tmpl periodic.hourly.obnam $hourly &&
    tmpl periodic.daily.obnam $daily
}
