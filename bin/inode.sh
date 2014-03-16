inode() {
  local type=$1
  local p=$2
  local mode=$3
  local user=$4
  local group=$5
  local exists s_mode s_user s_group err code

  case $type in
    dir)
      [ -d $p ] || mkdir -p $p
      exists=$?
      ;;
    file)
      [ -f $p ] || touch $p
      exists=$?
      ;;
  esac

  [ $exists -eq 0 ] || return $exists

  s_mode=$(stat -c %a $p)
  s_user=$(stat -c %U $p)
  s_group=$(stat -c %G $p)

  [ $s_mode = $mode -a $s_user = $user -a $s_group = $group ] && return 0

  progress start "inode $type" $p
  err=$(chmod $mode $p && chown $user $p && chgrp $group $p)
  code=$?
  progress finish $code
  [ -z "$err" ] || progress result "$err"
  return $code
}
