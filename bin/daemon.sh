_daemon_enable() {
  local name=$1
  local runlevel=$2

  [ "$runlevel" ] || runlevel=default

  case $system in
    void)
      inode link /etc/sv/$name /var/service/$name
      ;;
    alpine)
      rc-update show | grep -q "^  *$name  *|" || {
        progress wrap 'daemon enable' $name \
          "rc-update add $name $runlevel >/dev/null"
        _daemon_restart $name
      }
      ;;
  esac
}

_daemon_restart() {
  case $system in
    void)
      progress wrap 'daemon restart' $1 "sv restart /var/service/$1 >/dev/null"
      ;;
    alpine)
      progress wrap 'daemon restart' $1 "/etc/init.d/$1 -q restart 2>/dev/null"
      ;;
  esac
}

daemon() {
  local action=$1
  shift
  _daemon_$action "$@"
}
