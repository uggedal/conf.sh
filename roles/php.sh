php_role() {
  pkg add php-fpm php-sqlite &&
    daemon enable php-fpm
}
