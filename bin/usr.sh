_usr_add() {
  local user=$1
  local group=$2
  local shell=$3

  id $user >/dev/null 2>&1 || \
    progress wrap 'usr add' $user "adduser -D -s $shell -G $group $user"
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
