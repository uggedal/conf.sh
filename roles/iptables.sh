iptables_role() {
  pkg add iptables && \
    tmpl iptables.rule-save /etc/iptables/rules-save iptables && \
    daemon enable iptables && \
    daemon start iptables
}
