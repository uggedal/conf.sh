_progress_start() {
  local action="$1"
  local object="$2"

  printf '%-16s \033[33m%s\033[0m ' "$action" "$object"
}

_progress_finish() {
  if [ $1 -eq 0 ]; then
    printf '\033[32m✓'
  else
    printf '\033[31m✗'
  fi
  printf '\033[0m\n'
}

_progress_result() {
  printf '%s\n' "$1" | sed 's/^/  /'
}

_progress_wrap() {
  local action="$1"
  local object="$2"
  local cmd="$3"
  local err rc

  progress start "$action" "$object"
  err=$(eval "$cmd" 2>&1)
  rc=$?
  progress finish $rc
  [ -z "$err" ] || progress result "$err"
  [ $rc -eq 0 ] || return $rc
}

progress() {
  action=_progress_$1
  shift
  $action "$@"
}
