development_role() {
  pkg accept =dev-vcs/hub-1.11.0 ~amd64
  pkg accept =dev-util/clib-9999 ~amd64

  pkg world \
    app-editors/vim \
    app-misc/tmux \
    dev-vcs/git \
    dev-vcs/hub \
    app-shells/bash-completion \
    sys-fs/inotify-tools \
    sys-fs/ncdu \
    sys-process/htop \
    sys-process/lsof \
    sys-devel/bc \
    dev-util/clib

  for target in base coreutils man gentoo ssh tmux git;do
    [ -h /etc/bash_completion.d/$target ] \
      || eselect bashcomp enable --global $target
  done

  pkg select editor /usr/bin/vi
}
