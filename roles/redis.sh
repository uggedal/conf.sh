redis_role() {
  pkg add redis &&
    tmpl redis.conf /etc/redis.conf redis &&
    daemon enable redis &&
    daemon start redis
}
