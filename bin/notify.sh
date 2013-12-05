notify() {
  handler=${1}_handler
  shift
  $handler "$@"
}
