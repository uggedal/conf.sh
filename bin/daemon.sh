_daemon_enable() {
  inode link /etc/sv/$1 /var/service/$1
}

_daemon_restart() {
  progress wrap 'daemon restart' $1 "sv restart /var/service/$1 >/dev/null"
}

daemon() {
  local action=$1
  shift
  _daemon_$action "$@"
}
