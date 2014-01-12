portage_role() {
  tmpl rsync_excludes /etc/portage/rsync_excludes && \
    tmpl make.conf /etc/portage/make.conf
}
