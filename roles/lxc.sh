_lxc_create() {
  local container=$1
  local cmd

  lxc-ls | grep -q ^$name\$ && return

  cmd="lxc-create -n $name -B $_lxc_fs -t alpine"
  cmd="$cmd -- --repository $_lxc_mirror/$release/main"

  progress wrap 'lxc create' $name "$cmd >/dev/null"
}

_lxc_containers() {
  local ip_prefix=${_network_bridge_address%.*}
  local ip_suffix=10
  local name release rootfs

  for container in $_lxc_containers; do
    name=${container%%:*}
    release=${container##*:}
    ip_suffix=$(($ip_suffix + 1))
    rootfs=/var/lib/lxc/$name/rootfs

    _lxc_create $name $release || return 1

    export _lxc_container_address=${ip_prefix}.${ip_suffix}
    tmpl lxc.container.interfaces \
      $rootfs/etc/network/interfaces || return 1

    inode link $rootfs/etc/init.d/networking \
      $rootfs/etc/runlevels/default/networking 777 || return 1
  done
}

lxc_role() {
  pkg add lxc lxc-templates && \
    tmpl lxc.default.conf /etc/lxc/default.conf

  _lxc_containers
}
