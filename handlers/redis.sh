redis_handler() {
  local kind=$1
  local state=$2
  local file=$3

  [ "$file" = /etc/redis/redis.conf ] && daemon restart redis
  [ "$file" = /etc/sysctl.d/redis.conf ] && sysctl -q -p $file
}
