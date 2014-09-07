user_role() {
  pkg add bash git &&
    usr add -u $_user_name -g $_user_group -s /bin/bash &&
    usr groups $_user_name $_user_groups &&
    usr sshkey $_user_name "$_user_sshkey" &&
    usr dotfiles $_user_name

  [ -z "$_user_autologin" ] |
    tmpl sv.agetty-tty1.run /etc/sv/agetty-tty1/run
}
