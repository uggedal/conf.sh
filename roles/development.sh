development_role() {
  pkg use dev-vcs/git -gpg -webdav
  pkg use dev-lang/ruby -rdoc -yaml
  pkg accept =dev-vcs/hub-1.11.0 ~amd64
  pkg world \
    app-editors/vim \
    app-misc/tmux \
    dev-vcs/git \
    dev-vcs/hub \
    app-shells/bash-completion \
    sys-process/htop
}
