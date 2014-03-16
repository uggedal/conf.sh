inode() {
  local type=$1
  local p=$2
  local mode=$3
  local user=$4
  local group=$5
  local rc=0
  local s_mode s_user s_group err code

  case $type in
    dir)
      [ -d $p ] || {
        progress wrap "$type create" $p "mkdir -p $p"
        rc=$?
      }
      ;;
    file)
      [ -f $p ] || {
        progress wrap "$type create" $p "touch $p"
        rc=$?
      }
      ;;
  esac

  [ $rc -eq 0 ] || return $rc

  s_mode=$(stat -c %a $p)
  s_user=$(stat -c %U $p)
  s_group=$(stat -c %G $p)

  [ $s_mode = $mode -a $s_user = $user -a $s_group = $group ] && return 0

  progress wrap "$type mode" $p \
    "chmod $mode $p && chown $user $p && chgrp $group $p"
}
