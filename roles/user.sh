_add_user() {
  id $_user_name >/dev/null 2>&1 || \
    useradd -m -s $_user_shell -g $_user_group $_user_name
}

_add_groups() {
  for g in $_user_groups; do
    id -nG $_user_name | grep -q $g || usermod -a -G $g $_user_name || return 1
  done
}

_unlock_user() {
  ! grep ^$_user_name:!: /etc/shadow >/dev/null || \
    passwd -u $_user_name
}

_ssh_auth() {
  local ssh_dir=/home/$_user_name/.ssh
  local ssh_auth_file=$ssh_dir/authorized_keys

  inode dir $ssh_dir 700 $_user_name $_user_group || return 1
  inode file $ssh_auth_file 600 $_user_name $_user_group || return 1

  fgrep "$_user_authorized_key" $ssh_auth_file >/dev/null || \
    printf '%s\n' "$_user_authorized_key" >> $ssh_auth_file || \
    return 1
}

_dotfiles() {
  local home_dir=/home/$_user_name

  [ -d $home_dir/.git ] || \
    sudo -u $_user_name sh -c "cd $home_dir && git init" || \
    return 1

  inode dir $home_dir/.git 755 $_user_name $_user_group && \
  inode file $home_dir/.git/config 644 $_user_name $_user_group && \
  tmpl dotfiles_config $home_dir/.git/config
}

user_role() {
  _add_user && _add_groups && _unlock_user && _ssh_auth && _dotfiles
}
