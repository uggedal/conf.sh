development_role() {
  pkg use dev-vcs/git -gpg -webdav
  pkg world app-editors/vim app-misc/tmux dev-vcs/git
}
