sudo_role() {
  local f=/etc/sudoers.d/wheel

  pkg add sudo && \
    inode file $f 440 root && \
    tmpl sudoers.d.wheel $f
}
