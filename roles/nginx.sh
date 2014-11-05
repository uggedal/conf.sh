_nginx_sites() {
  local fqdn conf
  for i in $(seq 1 9); do
    fqdn=$(var get nginx $i fqdn)
    [ -z "$fqdn" ] && return

    conf=/etc/nginx/conf.d/${fqdn}.conf

    inode dir /srv/http/${fqdn} 755 nginx || return 1
    inode file $conf 644 || return 1

    for v in fqdn aliases root upstream static_prefix \
             cgi_script cgi_pass subdomain_redirect autoindex; do
      var export nginx $i $v
    done

    [ -n "$_nginx_root" ] || _nginx_root=/srv/http/$_nginx_fqdn

    tmpl -s /etc/nginx/conf.d/site.conf -d $conf -h nginx
  done
}

nginx_role() {
  pkg add nginx &&
    tmpl -s /etc/nginx/nginx.conf -h nginx &&
    tmpl -s /etc/nginx/conf.d/default.conf -h nginx &&
    tmpl -s /etc/logrotate.d/nginx &&
    daemon enable nginx &&
    inode dir /etc/nginx/conf.d 755 &&
    _nginx_sites
}
