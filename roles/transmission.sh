transmission_role() {
  local conf=/var/lib/transmission/.config/transmission-daemon/settings.json

  pkg add transmission \
    transmission-remote-cli &&
    inode dir /etc/sv/transmission &&
    inode file /etc/sv/transmission/run 755 &&
    tmpl -s /etc/sv/transmission/run &&
    inode file $conf 600 transmission &&
    tmpl -s $conf -h transmission &&
    daemon enable transmission
}
