uwsgi_handler() {
  local kind=$1
  local state=$2
  local file=$3

  daemon restart $(basename $(dirname $file))
}
