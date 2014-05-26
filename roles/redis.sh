redis_role() {
  pkg add redis &&
    tmpl redis.conf /etc/redis.conf redis &&
    tmpl sysctl.d.redis.conf /etc/sysctl.d/redis.conf redis &&
    daemon enable redis &&
    daemon start redis
}
