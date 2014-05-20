nginx_role() {
  pkg add nginx &&
    tmpl nginx.conf /etc/nginx/nginx.conf nginx
    daemon enable nginx && \
    daemon start nginx
}
