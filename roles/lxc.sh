_lxc_create() {
  local container=$1
  local name=${container%%:*}
  local release=${container##*:}
  local cmd

  lxc-ls | grep -q ^$name\$ && return

  cmd="lxc-create -n $name -B $_lxc_fs -t alpine"
  cmd="$cmd -- --repository $_lxc_mirror/$release/main"

  progress wrap lxc $name "$cmd >/dev/null"
}

lxc_role() {
  pkg add lxc lxc-templates && \
    tmpl lxc.default.conf /etc/lxc/default.conf

  for container in $_lxc_containers; do
    _lxc_create $container
  done
}
