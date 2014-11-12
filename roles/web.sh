web_role() {
  local weekly=/etc/cron.weekly/adblock

  pkg add vimb \
    mupdf \
    pass \
    pockyt

  inode file $weekly 740 &&
    tmpl -s $weekly
}
