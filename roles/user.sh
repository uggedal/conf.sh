#!/bin/sh

set -e

id $_user_name >/dev/null 2>&1 || adduser -D -s $_user_shell -G $_user_group $_user_name
for g in $_user_groups; do
  id -nG $_user_name | grep -q $g || addgroup $_user_name $g
done

ssh_dir=/home/$_user_name/.ssh
ssh_auth_file=$ssh_dir/authorized_keys
inode dir $ssh_dir 700 $_user_name $_user_group
inode file $ssh_auth_file 600 $_user_name $_user_group

if ! fgrep "$_user_authorized_key" $ssh_auth_file >/dev/null; then
  printf '%s\n' "$_user_authorized_key" >> $ssh_auth_file
fi
