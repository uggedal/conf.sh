_var_get() {
  eval printf '%s' \"\$_${1}_${2}_${3}\"
}

_var_export() {
  eval export _${1}_${3}=\"\$_${1}_${2}_${3}\"
}

var() {
  local action=_var_$1
  shift

  $action "$@"
}
