cgi_role() {
  local name
  local initd=/etc/init.d/spawn-fcgi

  pkg add fcgiwrap spawn-fcgi || return 1

  inode dir /var/run/spawn-fcgi 755 nginx || return 1

  export _cgi_name
  for _cgi_name in $_cgi_names; do
    inode link $initd $initd.$_cgi_name 755 || return 1
    tmpl conf.d.spawn-fcgi /etc/conf.d/spawn-fcgi.$_cgi_name || return 1
    daemon enable spawn-fcgi.$_cgi_name || return 1
    daemon start spawn-fcgi.$_cgi_name || return 1
  done

}
