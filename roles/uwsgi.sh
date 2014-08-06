_uwsgi_vassals() {
  local fqdn conf
  for i in $(seq 1 9); do
    fqdn=$(var get uwsgi $i fqdn)
    [ -z "$fqdn" ] && return

    conf=/etc/uwsgi.d/${fqdn}.ini

    inode file $conf 644 || return 1

    for v in chdir pkg module django processes idle; do
      var export uwsgi $i $v
    done

    pkg add $_uwsgi_pkg || return 1

    tmpl uwsgi.d $conf || return 1
  done
}


uwsgi_role() {
  pkg add uwsgi uwsgi-python &&
    inode dir /etc/uwsgi.d 755 root &&
    inode dir /var/log/uwsgi 755 nginx &&
    tmpl conf.d.uwsgi /etc/conf.d/uwsgi uwsgi &&
    tmpl logrotate.d.uwsgi /etc/logrotate.d/uwsgi &&
    daemon enable uwsgi &&
    daemon start uwsgi &&
    _uwsgi_vassals
}
