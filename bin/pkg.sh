# TODO: abstract progress

_pkg_add() {
  local err rc

  for p do
    apk info --quiet --installed $p || {
      progress start pkg $p add
      err=$(apk add --quiet $p 2>&1)
      rc=$?
      progress finish $rc
      [ -z "$err" ] || progress result "$err"
      [ $rc -eq 0 ] || return $rc
    }
  done
}

_pkg_sync() {
  local err rc

  progress start pkg '' sync
  err=$(apk update --quiet 2>&1)
  rc=$?
  progress finish $rc
  [ -z "$err" ] || progress result "$err"
  [ $rc -eq 0 ] || return $rc
}

_pkg_upgrade() {
  local err rc

  progress start pkg '' upgrade
  err=$(apk upgrade --quiet 2>&1)
  rc=$?
  progress finish $rc
  [ -z "$err" ] || progress result "$err"
  [ $rc -eq 0 ] || return $rc
}

pkg() {
  local action=$1
  shift

  _pkg_$action "$@"
}
