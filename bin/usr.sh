_has_id() {
  cut -d: -f1 /etc/$1 | grep -q "^$2\$"
}

_usr_add() {
  local user group

  local gcmd=addgroup
  local ucmd='adduser -D'

  while getopts "u:g:s:h:S" opt; do
    case $opt in
      u)
        user=$OPTARG
        ;;
      g)
        group=$OPTARG
        ucmd="$ucmd -G $OPTARG"
        ;;
      s)
        ucmd="$ucmd -s $OPTARG"
        ;;
      h)
        ucmd="$ucmd -H -h $OPTARG"
        ;;
      S)
        gcmd="$gcmd -S"
        ucmd="$ucmd -S"
        ;;
    esac
  done

  [ -n "$user" -a -n "$group" ] || return 1

  _has_id group $group ||
    progress wrap 'usr group' $user "$gcmd $group"

  _has_id passwd $user ||
    progress wrap 'usr add' $user "$ucmd $user"
}

_usr_unlock() {
  local user=$1

  ! grep "^$user:!:" /etc/shadow >/dev/null || \
    progress wrap 'usr unlock' $user "passwd -u $user >/dev/null"
}

_usr_groups() {
  local user=$1
  local groups=$2
  local gcmd


  for g in $groups; do
    id -nG $user | fgrep -q $g || gcmd="${gcmd}addgroup $user $g && "
  done

  [ -z "$gcmd" ] || progress wrap 'usr groups' $user "${gcmd}true"
}

_usr_sshkey() {
  local user=$1
  local key="$2"
  local dir=/home/$user/.ssh
  local file=$dir/authorized_keys
  local group

  inode dir $dir 700 $user || return 1
  inode file $file 600 $user || return 1

  fgrep "$key" $file >/dev/null || \
    progress wrap 'usr sshkey' $user "printf '%s\n' \"$key\" >> $file"
}

_usr_dotfiles() {
  local user=$1
  local dir=/home/$user

  [ -d $dir/.git ] || \
    su -l $user -c "cd $dir && git init" || \
    return 1

  inode dir $dir/.git 755 $user && \
    inode file $dir/.git/config 644 $user && \
    tmpl dotfiles_config $dir/.git/config
}

usr() {
  local action=_usr_$1
  shift

  $action "$@"
}
