php_role() {
  pkg add php-fpm php-sqlite &&
    tmpl -s /etc/php/php.ini -h php &&
    tmpl -s /etc/php/php-fpm.conf -h php &&
    daemon enable php-fpm
}
