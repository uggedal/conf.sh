httpd_role() {
  pkg world www-servers/nginx && \
    pkg exists www-servers/nginx && \
    daemon enable nginx && \
    daemon start nginx && \
    tmpl nginx.conf /etc/nginx/nginx.conf httpd
}
