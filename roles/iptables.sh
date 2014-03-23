iptables_role() {
  pkg add iptables && \
    daemon enable iptables && \
    daemon start iptables && \
    tmpl iptables.rule-save /etc/iptables/rules-save iptables
}
