_site_var() {
  eval printf '%s' \$_nginx_site_${2}_${1}
}

_site_template() {
  local fqdn="$(_site_var fqdn $1)"
  local aliases="$(_site_var aliases $1)"
  local subdomain_to_path_alias="$(_site_var subdomain_to_path_alias $1)"
  local upstreams="$(_site_var upstreams $1)"
  local default="$(_site_var default $1)"
  local autoindex="$(_site_var autoindex $1)"
  local uwsgi="$(_site_var uwsgi $1)"
  local static_prefix="$(_site_var static_prefix $1)"

  local root=/var/www/$fqdn
  local upstream_name=$(printf '%s' $fqdn | tr . -)

  local name=${fqdn}.conf
  local template=$(dirname $0)/templates/$name
  local conf=/etc/nginx/conf.d/$name

  inode dir $root 755 nginx nginx || return 1
  inode file $conf 644 root root || return 1

  >$template

  [ -z "$aliases" ] || cat <<EOF >> $template
server {
  server_name $aliases;
  rewrite ^ http://${fqdn}\$request_uri? permanent;
}
EOF

  [ -z "$subdomain_to_path_alias" ] || cat <<EOF >> $template
server {
  server_name $subdomain_to_path_alias;
  rewrite ^ http://$fqdn/${subdomain_to_path_alias%%.*}\$request_uri? permanent;
}
EOF

  [ -z "$upstreams" ] || {
    printf 'upstream %s {\n' $upstream_name >> $template
    printf '  server %s fail_timeout=0;\n' $upstreams >> $template
    printf '}\n' >> $template
  }

  printf 'server {\n' >> $template

  [ "$default" = true ] && \
    printf '  listen 80 default_server deferred;\n' >> $template

  cat <<EOF >> $template
  server_name $fqdn;
  client_max_body_size 10m;

  root $root;

  access_log  /var/log/nginx/${fqdn}.access.log;

  keepalive_timeout 5;

  location ~ /(favicon.ico|robots.txt) {
    access_log off;
    log_not_found off;
  }
EOF

  [ -z "$static_prefix" ] || cat <<EOF >> $template
  location $static_prefix {
    expires max;
    access_log off;
  }
EOF

  cat <<EOF >> $template
  location = /favicon.ico {
    expires 3M;
    access_log off;
  }
EOF

  printf '  location / {\n' >> $template

  if [ -z "$upstreams" ]; then
    printf '    index  index.html;\n' >> $template

    [ "$autoindex" = true ] && \
      cat <<EOF >> $template
    fancyindex on;
    fancyindex_exact_size off;
EOF
  else
    printf '    try_files $uri @%s;\n' $upstream_name >> $template
  fi

  printf '  }\n' >> $template

  [ -z "$upstreams" ] || {
    printf '  location @%s  {\n' $upstream_name >> $template

    if [ "$uwsgi" = true ]; then
  cat <<EOF >> $template
    include uwsgi_params;
    uwsgi_pass $upstream_name;
EOF
    else
  cat <<EOF >> $template
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header Host \$http_host;
    proxy_redirect off;
    proxy_pass http://$upstream_name;
EOF
    fi

    printf '  }\n' >> $template
  }

  printf '}\n' >> $template

  tmpl $name $conf nginx
}

nginx_role() {
  pkg world www-servers/nginx && \
    daemon enable nginx && \
    daemon start nginx && \
    tmpl nginx.mime /etc/nginx/mime.types nginx && \
    tmpl nginx.conf /etc/nginx/nginx.conf nginx && \
    inode dir /etc/nginx/conf.d 755 root root

  for i in $(seq 1 9); do
    [ -z "$(_site_var fqdn $i)" ] && return 0
    _site_template $i || return 1
  done
}
