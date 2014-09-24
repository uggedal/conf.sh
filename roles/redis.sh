redis_role() {
  pkg add redis &&
    inode dir /var/log/redis 750 redis &&
    tmpl -s /etc/logrotate.d/redis &&
    tmpl -s /etc/redis/redis.conf -h redis &&
    inode dir /etc/sysctl.d 755 &&
    tmpl -s /etc/sysctl.d/redis.conf -h redis &&
    daemon enable redis
}
