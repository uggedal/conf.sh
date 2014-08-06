_nginx_sites() {
  local fqdn conf
  for i in $(seq 1 9); do
    fqdn=$(var get nginx $i fqdn)
    [ -z "$fqdn" ] && return

    conf=/etc/nginx/conf.d/${fqdn}.conf

    inode dir /var/www/${fqdn} 755 nginx || return 1
    inode file $conf 644 || return 1

    for v in fqdn aliases root upstream static_prefix \
             cgi_script cgi_pass subdomain_redirect; do
      var export nginx $i $v
    done

    [ -n "$_nginx_root" ] || _nginx_root=/var/www/$_nginx_fqdn

    tmpl nginx.conf.d $conf nginx
  done
}

nginx_role() {
  pkg add nginx &&
    tmpl nginx.conf /etc/nginx/nginx.conf nginx &&
    tmpl logrotate.d.nginx /etc/logrotate.d/nginx &&
    daemon enable nginx &&
    daemon start nginx &&
    inode dir /etc/nginx/conf.d 755 &&
    _nginx_sites
}
