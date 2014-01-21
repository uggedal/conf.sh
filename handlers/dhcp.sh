dhcp_handler() {
  local action=$1
  local state=$2
  local object=$3

  [ "$action" = tmpl -a "$state" = changed ] && \
    [ "$object" = /etc/conf.d/net ] && \
    ln -s /etc/init.d/net.lo /etc/init.d/net.$_dhcp_if
}
