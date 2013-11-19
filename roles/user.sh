#!/bin/sh

set -e

home_dir=/home/$_user_name
ssh_dir=$home_dir/.ssh
ssh_auth_file=$ssh_dir/authorized_keys

id $_user_name >/dev/null 2>&1 \
  || adduser -D -s $_user_shell -G $_user_group $_user_name
for g in $_user_groups; do
  id -nG $_user_name | grep -q $g || addgroup $_user_name $g
done

grep ^$_user_name:!: /etc/shadow >/dev/null && passwd -u $_user_name

inode dir $ssh_dir 700 $_user_name $_user_group
inode file $ssh_auth_file 600 $_user_name $_user_group

fgrep "$_user_authorized_key" $ssh_auth_file >/dev/null || \
  printf '%s\n' "$_user_authorized_key" >> $ssh_auth_file

[ -d $home_dir/.git ] || \
  sudo -u $_user_name sh -c "cd $home_dir && git init"

inode dir $home_dir/.git 755 $_user_name $_user_group
inode file $home_dir/.git/config 644 $_user_name $_user_group
tmpl dotfiles_config $home_dir/.git/config
