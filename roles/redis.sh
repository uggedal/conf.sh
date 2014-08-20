redis_role() {
  pkg add redis &&
    inode dir /var/log/redis 750 redis &&
    tmpl logrotate.d.redis /etc/logrotate.d/redis &&
    tmpl redis.redis.conf /etc/redis/redis.conf redis &&
    inode dir /etc/sysctl.d 755 &&
    tmpl sysctl.d.redis.conf /etc/sysctl.d/redis.conf redis &&
    daemon enable redis
}
