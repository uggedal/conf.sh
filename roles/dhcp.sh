dhcp_role() {
  pkg world net-misc/dhcpcd && \
    tmpl net.confd /etc/conf.d/net dhcp && \
    daemon enable net.$_dhcp_if
}
