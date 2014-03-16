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

pkg() {
  local action=$1
  shift

  _pkg_$action "$@"
}
