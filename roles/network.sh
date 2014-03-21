network_role() {
  [ -z "$_network_brigde_if" ] || pkg add bridge || return 1

  tmpl network.interfaces /etc/network/interfaces
}
