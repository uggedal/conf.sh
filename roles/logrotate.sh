logrotate_role() {
  pkg add logrotate &&
    inode dir /etc/logrotate.d 755
}
