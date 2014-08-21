_uwsgi_services() {
  local fqdn service
  for i in $(seq 1 9); do
    fqdn=$(var get uwsgi $i fqdn)
    [ -z "$fqdn" ] && return

    service=uwsgi-$fqdn

    inode dir /etc/sv/$service 755 || return 1

    for v in chdir fqdn module django processes idle; do
      var export uwsgi $i $v
    done

    inode file /etc/sv/$service/run 755 &&
      tmpl sv.uwsgi.run /etc/sv/$service/run uwsgi &&
      inode link /run/runit/supervise.$service /etc/sv/$service/supervise &&
      daemon enable $service
  done
}


uwsgi_role() {
  pkg add uwsgi &&
    inode dir /var/log/uwsgi 755 nginx &&
    tmpl logrotate.d.uwsgi /etc/logrotate.d/uwsgi &&
    _uwsgi_services
}
