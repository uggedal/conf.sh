_progress_start() {
  local action=$1
  local object=$2
  local state=$3

  printf '%-6s \e[33m%s\e[0m ' $action $object
  [ $# -eq 3 ] && printf '%s ' $state || true
}

_progress_finish() {
  if [ $1 -eq 0 ]; then
    printf '\e[32m✓'
  else
    printf '\e[31m✗'
  fi
  printf '\e[0m\n'
}

_progress_result() {
  printf '%s\n' "$1" | sed 's/^/  /'
}

progress() {
  action=_progress_$1
  shift
  $action "$@"
}
