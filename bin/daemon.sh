_daemon_started() {
  local name=$1

  /etc/init.d/$name status >/dev/null
}

_daemon_stopped() {
  local name=$1

  /etc/init.d/$name status >/dev/null
  [ $? -eq 3 ]
}

_daemon_change_state() {
  local state=$1
  local name=$2

  case $state in
    start)
      _daemon_started $name && return
      ;;
    stop)
      _daemon_stopped $name && return
      ;;
  esac

  progress wrap "daemon $state" $name "/etc/init.d/$name -q $state"
}

_daemon_enabled() {
  rc-update show | sed 's/ //g' | cut -d'|' -f1
}

_daemon_enable() {
  local name=$1

  _daemon_enabled | grep "^$name\$" >/dev/null && return

  progress wrap 'daemon enable' $name "rc-update add $name default >/dev/null"
}

daemon() {
  action=$1
  shift

  case $action in
    start|stop|restart)
      _daemon_change_state $action "$@"
      ;;
    enable)
      _daemon_enable "$@"
      ;;
  esac
}
