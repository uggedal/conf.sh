{{#_nginx_aliases}}
  server {
    server_name {{_nginx_aliases}};
    rewrite ^ http://{{_nginx_fqdn}}$request_uri? permanent;
  }
{{/_nginx_aliases}}

{{#_nginx_subdomain_redirect}}
  server {
    server_name {{_nginx_subdomain_redirect}}.{{_nginx_fqdn}};
    rewrite ^ http://{{_nginx_fqdn}}/{{_nginx_subdomain_redirect}}$request_uri? permanent;
  }
{{/_nginx_subdomain_redirect}}

server {
  server_name {{_nginx_fqdn}};
  client_max_body_size 10m;

  root /var/www/{{_nginx_fqdn}};

  access_log  /var/log/nginx/{{_nginx_fqdn}}.access_log;

  keepalive_timeout 5;

  location ~ /(favicon.ico|robots.txt) {
    access_log off;
    log_not_found off;
  }

  location / {
    index  index.html;
  }
}
