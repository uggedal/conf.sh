shell_role() {
  local dest=/etc/profile.d/vimode.sh

  inode file $dest 644 root root &&
    tmpl profile.d.vimode.sh $dest
}
