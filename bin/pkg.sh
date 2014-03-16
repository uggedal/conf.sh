_pkg_add() {
  local err rc

  for p do
    apk info --quiet --installed $p || \
      progress wrap 'pkg add' $p "apk add --quiet $p"
  done
}

_pkg_sync() {
  progress wrap pkg sync 'apk update --quiet'
}

# TODO: apk update returns 0 on wget error
_pkg_upgrade() {
  progress wrap pkg upgrade 'apk upgrade --quiet'
}

pkg() {
  local action=_pkg_$1
  shift

  $action "$@"
}
