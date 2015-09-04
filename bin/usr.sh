_usr_field() {
  grep "^$3:" /etc/$1 | cut -d: -f$2
}

_usr_add() {
  local opt user group shell gcmd ucmd

  local gbin=groupadd
  local ubin=useradd

  command -v $gbin >/dev/null || gbin=addgroup
  command -v $ubin >/dev/null || {
    ubin=adduser
    ucmd="-D"
  }

  while getopts "u:g:s:h:S" opt; do
    case $opt in
      u)
        user=$OPTARG
        ;;
      g)
        group=$OPTARG
        if [ "$ubin" = useradd ]; then
          ucmd="$ucmd -g $OPTARG"
        else
          ucmd="$ucmd -G $OPTARG"
        fi
        ;;
      s)
        shell=$OPTARG
        ucmd="$ucmd -s $OPTARG"
        ;;
      h)
        if [ "$ubin" = useradd ]; then
          ucmd="$ucmd -M -d $OPTARG"
        else
          ucmd="$ucmd -H -h $OPTARG"
        fi
        ;;
      S)
        if [ "$ubin" = useradd ]; then
          gcmd="$gcmd -r"
          ucmd="$ucmd -r"
        else
          gcmd="$gcmd -S"
          ucmd="$ucmd -S"
        fi
        ;;
    esac
  done

  [ -n "$user" -a -n "$group" ] || return 1

  _usr_field group 1 $group | grep -q "^$group\$" ||
    progress wrap 'usr group' $user "$gbin $gcmd $group"

  _usr_field passwd 1 $user | grep -q "^$user\$" ||
    progress wrap 'usr add' $user "$ubin $ucmd $user"

  local chsh
  if command -v chsh >/dev/null; then
    chsh="chsh -s $shell $user"
  else
    chsh="sed -i '/$user:/s|:[^:]*$|:$shell|' /etc/passwd"
  fi

  [ "$(_usr_field passwd 7 $user)" = "$shell" ] ||
    progress wrap 'usr shell' "$user $shell" "$chsh"
}

_usr_groups() {
  local user=$1
  shift
  local groups
  groups="$@"
  local ok=1
  local cmd

  for g in $groups; do
    ! id -nG $user | tr ' ' '\n' | fgrep -q $g || continue

    if command -v usermod >/dev/null; then
      ok=0
    elif command -v addgroup >/dev/null; then
      cmd="${cmd}addgroup $user $g && "
    fi
  done

  local csv=$(printf "$groups" | tr ' ' ',')

  [ "$ok" -eq 1 ] || progress wrap 'usr groups' $user "usermod -aG $csv $user"
  [ -z "$cmd" ] || progress wrap 'usr groups' $user "${cmd}true"
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
