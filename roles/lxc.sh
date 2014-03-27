_lxc_create() {
  local container=$1
  local cmd

  lxc-ls | grep -q ^$name\$ && return

  cmd="lxc-create -n $name -B $_lxc_fs -t alpine"
  cmd="$cmd -- --repository $_lxc_mirror/$release/main"

  progress wrap 'lxc create' $name "$cmd >/dev/null"
}

_container_field() {
  printf '%s' $1 | cut -d: -f$2
}

_lxc_containers() {
  local ip_prefix=${_network_bridge_address%.*}
  local ip_suffix name release rootfs

  for container in $_lxc_containers; do
    name=$(_container_field $container 1)
    release=$(_container_field $container 2)
    ip_suffix=$(_container_field $container 3)
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
