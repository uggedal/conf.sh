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

{{#_nginx_upstream}}
  upstream {{_nginx_fqdn}}-backend {
    server {{_nginx_upstream}} fail_timeout=0;
  }
{{/_nginx_upstream}}

server {
  server_name {{_nginx_fqdn}};
  client_max_body_size 10m;

  {{#_nginx_root}}
    root {{_nginx_root}};
  {{/_nginx_root}}
  {{^_nginx_root}}
    root /var/www/{{_nginx_fqdn}};
  {{/_nginx_root}}

  access_log  /var/log/nginx/{{_nginx_fqdn}}.access_log;

  keepalive_timeout 5;

  location ~ /(favicon.ico|robots.txt) {
    access_log off;
    log_not_found off;
  }

  {{#_nginx_static_prefix}}
    location {{_nginx_static_prefix}} {
      expires max;
      access_log off;
      log_not_found off;
    }
  {{/_nginx_static_prefix}}

  location / {
    {{#_nginx_upstream}}
      try_files $uri @{{_nginx_fqdn}}-backend;
    {{/_nginx_upstream}}
    {{^_nginx_upstream}}
      index  index.html;
    {{/_nginx_upstream}}
  }

  {{#_nginx_upstream}}
    location @{{_nginx_fqdn}}-backend  {
      {{#_nginx_cgi_script}}
        include fastcgi_params;
        fastcgi_param DOCUMENT_ROOT {{_nginx_root}};
        fastcgi_param SCRIPT_FILENAME {{_nginx_cgi_script}};
        fastcgi_pass {{_nginx_fqdn}}-backend;
      {{/_nginx_cgi_script}}
      {{^_nginx_cgi_script}}
        include uwsgi_params;
        uwsgi_pass {{_nginx_fqdn}}-backend;
      {{/_nginx_cgi_script}}
    }
  {{/_nginx_upstream}}
}
