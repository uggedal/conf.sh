iptables_role() {
  pkg add iptables && \
    tmpl iptables.rule-save /etc/iptables/rules-save iptables && \
    tmpl conf.d.iptables /etc/conf.d/iptables iptables && \
    daemon enable iptables && \
    daemon start iptables
}
