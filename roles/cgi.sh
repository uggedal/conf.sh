cgi_role() {
  local initd=/etc/init.d/spawn-fcgi

  pkg add fcgiwrap spawn-fcgi &&
    inode dir /etc/sv/spawn-fcgi &&
    inode file /etc/sv/spawn-fcgi/run 755 &&
    tmpl sv.spawn-fcgi.run /etc/sv/spawn-fcgi/run &&
    inode link /run/runit/supervise.spawn-fcgi /etc/sv/spawn-fcgi/supervise &&
    daemon enable spawn-fcgi
}
