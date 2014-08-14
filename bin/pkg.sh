_pkg_installed() {
  xbps-query $1 >/dev/null
}

_pkg_add() {
  local p

  for p do
    _pkg_installed $p && continue

    progress wrap 'pkg add' $p "xbps-install -y $p >/dev/null" || return 1
  done
}

pkg() {
  local action=_pkg_$1
  shift

  $action "$@"
}
