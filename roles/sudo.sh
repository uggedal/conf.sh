sudo_role() {
  local conf=/etc/sudoers
  local wheel=/etc/sudoers.d/wheel

  pkg add sudo &&
    inode file $conf 440 root &&
    tmpl sudoers $conf &&
    inode file $wheel 440 root &&
    tmpl sudoers.d.wheel $wheel
}
