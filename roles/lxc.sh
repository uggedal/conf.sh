_lxc_containers() {
  local i name template
  for i in $(seq 1 9); do
    name=$(var get lxc $i name)
    template=$(var get lxc $i template)
    [ -z "$name" ] && return
    [ -z "$template" ] && template=void

    lxc-ls | grep -q ^$name\$ && return

    progress wrap 'lxc create' $name \
      "lxc-create -n $name -t $template >/dev/null"
  done
}

lxc_role() {
  pkg add lxc &&
    tmpl -s /etc/lxc/default.conf &&
    _lxc_containers
}
