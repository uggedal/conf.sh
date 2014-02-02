portage_role() {
  tmpl rsync_excludes /etc/portage/rsync_excludes && \
    tmpl make.conf /etc/portage/make.conf || return 1

  . /etc/portage/make.conf
  for dir in $DISTDIR $PKGDIR; do
    inode dir $dir 0775 root portage || return 1
  done
}
