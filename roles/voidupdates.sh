voidupdates_role() {
  local cron=/var/spool/cron/voidupdates

  pkg add void-updates &&
    usr groups voidupdates nginx &&
    inode file $cron 600 &&
    tmpl -s $cron
}
