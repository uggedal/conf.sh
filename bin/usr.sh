_usr_add() {
  local user=$1
  local group=$2
  local shell=$3

  id $user >/dev/null 2>&1 || \
    progress wrap 'usr add' $user "adduser -D -s $shell -G $group $user"
}

_usr_groups() {
  local user=$1
  local groups=$3
  local gcmd


  for g in $groups; do
    id -nG $user | fgrep -q $g || gcmd="${gcmd}addgroup $user $g && "
  done

  [ -z "$gcmd" ] || progress wrap 'usr groups' $user "${gcmd}true"
}

usr() {
  local action=_usr_$1
  shift

  $action "$@"
}
