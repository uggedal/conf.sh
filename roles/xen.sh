xen_role() {
  local post=/etc/kernel.d/post-install/20-xen-grub

  inode file $post 755 &&
    tmpl -s $post
}
