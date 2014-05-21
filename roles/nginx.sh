nginx_role() {
  pkg add nginx && \
    tmpl nginx.conf /etc/nginx/nginx.conf nginx && \
    tmpl logrotate.d.nginx /etc/logrotate.d/nginx && \
    daemon enable nginx && \
    daemon start nginx
}
