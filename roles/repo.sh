repo_role() {
  inode dir /etc/xbps/repo.d &&
    tmpl xbps.repo.d.repo.conf /etc/xbps/repo.d/$_repo_name.conf
}
