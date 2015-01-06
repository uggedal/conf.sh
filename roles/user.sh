user_role() {
  local xbps_d=/etc/xbps.d

  pkg add zsh \
    zsh-syntax-highlighting \
    git &&
    usr add -u $_user_name -g $_user_group -s /bin/zsh &&
    usr groups $_user_name $_user_groups &&
    usr sshkey $_user_name "$_user_sshkey" &&
    usr dotfiles $_user_name

  [ -z "$_user_autologin" ] || {
    inode dir $xbps_d 755 &&
      tmpl -s $xbps_d/runit-void.conf &&
      tmpl -s /etc/sv/agetty-tty1/run
  }
}
