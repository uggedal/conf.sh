cgi_role() {
  local initd=/etc/init.d/spawn-fcgi

  pkg add fcgiwrap spawn-fcgi &&
    inode link $initd $initd.fcgiwrap 755 &&
    tmpl conf.d.spawn-fcgi /etc/conf.d/spawn-fcgi.fcgiwrap &&
    daemon enable spawn-fcgi.fcgiwrap &&
    daemon start spawn-fcgi.fcgiwrap
}
