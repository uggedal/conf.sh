_pkg_world_cache=

_pkg_installed() {
  [ -n "$_pkg_world_cache" ] || _pkg_world_cache="$(cat /etc/apk/world)"

  for p in $_pkg_world_cache; do
    [ "$p" = "$1" ] && return
  done
  return 1
}

_pkg_add() {
  local err rc variants

  for p do
    variants=$p
    [ -z "$_pkg_doc" ] || variants="$variants $p-doc"
    [ -z "$_pkg_bash_completion" ] || variants="$variants $p-bash-completion"

    for v in $variants; do
      _pkg_installed $v && continue

      [ $v = $p ] || [ -n "$(apk info --quiet --size $v)" ] || continue

      progress wrap 'pkg add' $v "apk add --quiet $v" || return 1
    done
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
