miniflux_role() {
  local db=/var/lib/miniflux/db.sqlite
  local cron=/var/spool/cron/miniflux

  pkg add miniflux &&
    usr groups nginx miniflux &&
    inode file $db 660 miniflux &&
    inode file $cron 600 &&
    tmpl -s $cron
}
