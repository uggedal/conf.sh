timezone_handler() {
  local action=$1
  local state=$2
  local object=$3

  [ "$action" = tmpl -a "$state" = changed ] && \
    [ "$object" = /etc/timezone ] && \
    emerge --config sys-libs/timezone-data >/dev/null
}
