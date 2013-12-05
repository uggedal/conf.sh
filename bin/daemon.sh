_daemon_started() {
  local name=$1

  case $(os) in
    alpine)
      /etc/init.d/$name status >/dev/null
      return $?
      ;;
  esac
}

_daemon_stopped() {
  local name=$1

  case $(os) in
    alpine)
      /etc/init.d/$name status >/dev/null
      return [ $? -eq 3 ]
      ;;
  esac
}

_daemon_change_stage() {
  local state=$1
  local name=$2
  local err code

  case $state in
    start)
      _daemon_started $name && return
      ;;
    stop)
      _daemon_stopped $name && return
      ;;
  esac

  case $(os) in
    alpine)
      progress start daemon $name $state
      err=$(/etc/init.d/$name -q $state 2>&1)
      code=$?
      progress finish $code
      [ -z "$err" -a $code -eq 0 ] || progress result "$err"
      ;;
  esac
}

_daemon_enabled() {
  case $(os) in
    alpine)
      rc-update show | sed 's/ //g' | cut -d'|' -f1
      ;;
  esac
}

_daemon_enable() {
  local name=$1
  local err code

  _daemon_enabled | grep "^$name\$" >/dev/null && return

  case $(os) in
    alpine)
      progress start daemon $name enable
      err=$(rc-update add $name default 2>&1)
      code=$?
      progress finish $code
      [ -z "$err" -a $code -ne 0 ] || progress result "$err"
      ;;
  esac
}

daemon() {
  action=$1
  shift

  case $action in
    start|stop|restart)
      _daemon_change_stage $action "$@"
      ;;
    enable)
      _daemon_enable "$@"
      ;;
  esac
}
