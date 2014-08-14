inode() {
  local type=$1
  local node=$2
  shift 2

  [ $type = link ] && {
    local target=$1
    shift
  }

  local mode=$1
  local user=$2
  local group=$3

  [ -n "$user" ] || user=root
  [ -n "$group" ] || group=$(id -ng $user)

  case $type in
    dir)
      [ -d $node ] || \
        progress wrap "$type create" $node "mkdir -p $node" || return 1
      ;;
    file)
      [ -f $node ] || \
        progress wrap "$type create" $node "touch $node" || return 1
      ;;
    link)
      [ -L $target ] || \
        progress wrap "$type create" $node "ln -s $node $target" || return 1
      ;;
  esac

  [ $(stat -c %a $node) != "$mode" ] &&
    progress wrap "$type mode" $node "chmod $mode $node"
  [ $(stat -c %U $node) != $user ] &&
    progress wrap "$type user" $node "chown $user $node"
  [ $(stat -c %G $node) != $group ] &&
    progress wrap "$type group" $node "chgrp $group $node" 
}
