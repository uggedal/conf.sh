_pkg_world_cache=

_pkg_installed() {
  local p

  case $system in
    void)
      xbps-query $1 >/dev/null
      ;;
    alpine)
      [ -n "$_pkg_world_cache" ] || _pkg_world_cache="$(cat /etc/apk/world)"

      for p in $_pkg_world_cache; do
        [ "$p" = "$1" ] && return
      done
      return 1
      ;;
  esac
}

_pkg_add() {
  local p

  for p do
    _pkg_installed $p && continue

    case $system in
      void)
        progress wrap 'pkg add' $p "xbps-install -y $p >/dev/null" || return 1
        ;;
      alpine)
        progress wrap 'pkg add' $p "apk add --quiet $p" || return 1
        ;;
    esac
  done
}

pkg() {
  local action=_pkg_$1
  shift

  $action "$@"
}
