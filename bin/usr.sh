_has_id() {
  cut -d: -f1 /etc/$1 | grep -q "^$2\$"
}

_usr_add() {
  local user group

  local gcmd=groupadd
  local ucmd=useradd

  while getopts "u:g:s:h:S" opt; do
    case $opt in
      u)
        user=$OPTARG
        ;;
      g)
        group=$OPTARG
        ucmd="$ucmd -g $OPTARG"
        ;;
      s)
        ucmd="$ucmd -s $OPTARG"
        ;;
      h)
        ucmd="$ucmd -M -d $OPTARG"
        ;;
      S)
        gcmd="$gcmd -r"
        ucmd="$ucmd -r"
        ;;
    esac
  done

  [ -n "$user" -a -n "$group" ] || return 1

  _has_id group $group ||
    progress wrap 'usr group' $user "$gcmd $group"

  _has_id passwd $user ||
    progress wrap 'usr add' $user "$ucmd $user"
}

_usr_groups() {
  local user=$1
  local groups=$2
  local ok=1

  for g in $groups; do
    id -nG $user | tr ' ' '\n' | fgrep -q $g || ok=0
  done

  local csv=$(printf "$groups" | tr ' ' ',')

  [ "$ok" -eq 1 ] || progress wrap 'usr groups' $user "usermod -G $csv $user"
}

_usr_sshkey() {
  local user=$1
  local key="$2"
  local dir=/home/$user/.ssh
  local file=$dir/authorized_keys
  local group

  inode dir $dir 700 $user || return 1
  inode file $file 600 $user || return 1

  fgrep "$key" $file >/dev/null ||
    progress wrap 'usr sshkey' $user "printf '%s\n' \"$key\" >> $file"
}

_usr_dotfiles() {
  local user=$1
  local dir=/home/$user

  [ -d $dir/.git ] ||
    su -l $user -c "cd $dir && git init" ||
    return 1

  inode dir $dir/.git 755 $user &&
    inode file $dir/.git/config 644 $user &&
    tmpl dotfiles_config $dir/.git/config
}

usr() {
  local action=_usr_$1
  shift

  $action "$@"
}
