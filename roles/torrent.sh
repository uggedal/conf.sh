torrent_role() {
  local conf=/var/lib/transmission/.config/transmission-daemon/settings.json

  pkg add transmission \
    transmission-remote-cli &&
    inode file $conf 600 transmission &&
    tmpl -s $conf -h transmission &&
    daemon enable transmission-daemon
}
