user_role() {
  local preserve_d=/etc/xbps/preserve.d

  pkg add zsh \
    zsh-syntax-highlighting \
    git &&
    usr add -u $_user_name -g $_user_group -s /bin/zsh &&
    usr groups $_user_name $_user_groups &&
    usr sshkey $_user_name "$_user_sshkey" &&
    usr dotfiles $_user_name

  [ -z "$_user_autologin" ] || {
    inode dir $preserve_d 755 &&
      tmpl -s $preserve_d/runit-void.conf &&
      tmpl -s /etc/sv/agetty-tty1/run
  }
}
