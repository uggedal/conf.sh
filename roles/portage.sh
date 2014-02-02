portage_role() {
  tmpl rsync_excludes /etc/portage/rsync_excludes && \
    tmpl make.conf /etc/portage/make.conf || return 1

  . /etc/portage/make.conf
  inode dir $DISTDIR 775 root portage
  inode dir $PKGDIR 2775 root portage
}
