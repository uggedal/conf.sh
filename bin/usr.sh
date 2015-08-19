_usr_field() {
  grep "^$3:" /etc/$1 | cut -d: -f$2
}

_usr_add() {
  local opt user group shell

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
        shell=$OPTARG
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

  _usr_field group 1 $group | grep -q "^$group\$" ||
    progress wrap 'usr group' $user "$gcmd $group"

  _usr_field passwd 1 $user | grep -q "^$user\$" ||
    progress wrap 'usr add' $user "$ucmd $user"

  [ "$(_usr_field passwd 7 $user)" = "$shell" ] ||
    progress wrap 'usr shell' "$user $shell" "chsh -s $shell $user"
}

_usr_groups() {
  local user=$1
  shift
  local groups
  groups="$@"
  local ok=1

  for g in $groups; do
    id -nG $user | tr ' ' '\n' | fgrep -q $g || ok=0
  done

  local csv=$(printf "$groups" | tr ' ' ',')

  [ "$ok" -eq 1 ] || progress wrap 'usr groups' $user "usermod -aG $csv $user"
}

_usr_sshkey() {
  local user=$1
  local key="$2"
  local dir
  eval dir=~$user/.ssh
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
    tmpl -s /home/_git/config -d $dir/.git/config
}

usr() {
  local action=_usr_$1
  shift

  $action "$@"
}
